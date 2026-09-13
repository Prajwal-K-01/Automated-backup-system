#!/bin/bash

# ==========================================
# Automated Backup System
# Backup Cleanup Script
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
# Validate Backup Directory
# ------------------------------------------

if [ ! -d "$BACKUP_DIR" ]; then
    echo "ERROR: Backup directory does not exist."
    exit 1
fi

mkdir -p "$(dirname "$LOG_FILE")"

# ------------------------------------------
# Start Logging
# ------------------------------------------

echo "========================================" >> "$LOG_FILE"
echo "Cleanup started: $(date)" >> "$LOG_FILE"

# ------------------------------------------
# Remove Old Backup Archives
# ------------------------------------------

find "$BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -mtime +"$RETENTION_DAYS" \
    -delete

# ------------------------------------------
# Remove Old Checksum Files
# ------------------------------------------

find "$BACKUP_DIR" \
    -type f \
    -name "*.tar.gz.sha256" \
    -mtime +"$RETENTION_DAYS" \
    -delete

# ------------------------------------------
# Completion
# ------------------------------------------

echo "Backups older than $RETENTION_DAYS days removed." >> "$LOG_FILE"
echo "Cleanup completed: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

echo "Cleanup completed successfully."
echo "Retention period: $RETENTION_DAYS days"
