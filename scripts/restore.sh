#!/bin/bash

# ==========================================
# Automated Backup System
# Backup Restore Script
# ==========================================

PROJECT_DIR="$HOME/automated-backup-system"
CONFIG_FILE="$PROJECT_DIR/config/backup.conf"

# ------------------------------------------
# Load Configuration
# ------------------------------------------

if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: Configuration file not found."
    exit 1
fi

source "$CONFIG_FILE"

# ------------------------------------------
# Validate Arguments
# ------------------------------------------

if [ $# -ne 2 ]; then
    echo
    echo "Usage:"
    echo "$0 <backup-file> <restore-directory>"
    echo
    echo "Example:"
    echo "$0 backups/archives/backup_2026-09-13_12-00-00.tar.gz restore-test"
    echo
    exit 1
fi

BACKUP_FILE="$1"
RESTORE_DIR="$2"

# ------------------------------------------
# Check Backup File
# ------------------------------------------

if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERROR: Backup file does not exist:"
    echo "$BACKUP_FILE"
    exit 1
fi

# ------------------------------------------
# Verify Checksum If Available
# ------------------------------------------

CHECKSUM_FILE="$BACKUP_FILE.sha256"

if [ -f "$CHECKSUM_FILE" ]; then

    echo "Verifying backup integrity..."

    if sha256sum -c "$CHECKSUM_FILE"; then
        echo "Checksum verification successful."
    else
        echo "ERROR: Checksum verification failed."
        echo "Restore cancelled."
        exit 1
    fi

else
    echo "WARNING: Checksum file not found."
    echo "Continuing without checksum verification."
fi

# ------------------------------------------
# Create Restore Directory
# ------------------------------------------

mkdir -p "$RESTORE_DIR"

# ------------------------------------------
# Restore Backup
# ------------------------------------------

echo "Restoring backup..."
echo "Backup: $BACKUP_FILE"
echo "Destination: $RESTORE_DIR"

tar -xzf "$BACKUP_FILE" -C "$RESTORE_DIR"

if [ $? -eq 0 ]; then
    echo
    echo "=========================================="
    echo "        RESTORE COMPLETED SUCCESSFULLY"
    echo "=========================================="
    echo "Restored to: $RESTORE_DIR"
else
    echo
    echo "ERROR: Restore operation failed."
    exit 1
fi
