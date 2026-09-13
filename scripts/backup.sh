#!/bin/bash

# ==========================================
# Automated Backup System
# Main Backup Script
# ==========================================

PROJECT_DIR="$HOME/automated-backup-system"
CONFIG_FILE="$PROJECT_DIR/config/backup.conf"

# ------------------------------------------
# Load Configuration
# ------------------------------------------

if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: Configuration file not found: $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"

# ------------------------------------------
# Create Required Directories
# ------------------------------------------

mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

# ------------------------------------------
# Timestamp
# ------------------------------------------

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
CHECKSUM_FILE="$BACKUP_FILE.sha256"

# ------------------------------------------
# Logging
# ------------------------------------------

echo "========================================" >> "$LOG_FILE"
echo "Backup started: $(date)" >> "$LOG_FILE"

# ------------------------------------------
# Check Source Directory
# ------------------------------------------

if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Source directory does not exist: $SOURCE_DIR" >> "$LOG_FILE"
    echo "Backup failed."
    exit 1
fi

echo "Source directory: $SOURCE_DIR" >> "$LOG_FILE"

# ------------------------------------------
# Check Disk Space
# ------------------------------------------

AVAILABLE_SPACE=$(df "$BACKUP_DIR" | awk 'NR==2 {print $4}')

if [ -z "$AVAILABLE_SPACE" ]; then
    echo "ERROR: Unable to determine available disk space." >> "$LOG_FILE"
    exit 1
fi

if [ "$AVAILABLE_SPACE" -lt "$MINIMUM_FREE_SPACE" ]; then
    echo "ERROR: Insufficient disk space." >> "$LOG_FILE"
    echo "Available space: ${AVAILABLE_SPACE} KB" >> "$LOG_FILE"
    exit 1
fi

echo "Disk space check passed." >> "$LOG_FILE"

# ------------------------------------------
# Create Compressed Backup
# ------------------------------------------

echo "Creating backup..." >> "$LOG_FILE"

tar -czf "$BACKUP_FILE" \
    -C "$(dirname "$SOURCE_DIR")" \
    "$(basename "$SOURCE_DIR")"

if [ $? -ne 0 ]; then
    echo "ERROR: Backup creation failed." >> "$LOG_FILE"
    echo "Backup failed."
    exit 1
fi

# ------------------------------------------
# Check Backup File
# ------------------------------------------

if [ ! -f "$BACKUP_FILE" ]; then
    echo "ERROR: Backup file was not created." >> "$LOG_FILE"
    exit 1
fi

# ------------------------------------------
# Generate SHA-256 Checksum
# ------------------------------------------

sha256sum "$BACKUP_FILE" > "$CHECKSUM_FILE"

if [ $? -ne 0 ]; then
    echo "ERROR: Checksum creation failed." >> "$LOG_FILE"
    exit 1
fi

echo "Checksum created: $CHECKSUM_FILE" >> "$LOG_FILE"

# ------------------------------------------
# Backup Information
# ------------------------------------------

BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)

echo "Backup file: $BACKUP_FILE" >> "$LOG_FILE"
echo "Backup size: $BACKUP_SIZE" >> "$LOG_FILE"

# ------------------------------------------
# Completion
# ------------------------------------------

echo "Backup completed successfully: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

echo
echo "=========================================="
echo "       BACKUP COMPLETED SUCCESSFULLY"
echo "=========================================="
echo "Backup : $BACKUP_FILE"
echo "Size   : $BACKUP_SIZE"
echo "SHA256 : $CHECKSUM_FILE"
echo "=========================================="
