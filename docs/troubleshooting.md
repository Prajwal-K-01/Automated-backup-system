# Troubleshooting Guide

## 1. Overview

This guide provides solutions for common problems that may occur while installing, configuring, running, restoring, or automating the **Automated Backup System**.

The troubleshooting process mainly involves checking:

* Script permissions
* Configuration
* Source and backup directories
* Disk space
* Backup files
* SHA-256 checksums
* Cron service
* Log files

---

# 2. Configuration File Not Found

### Problem

You see:

```text
ERROR: Configuration file not found
```

### Cause

The script cannot find:

```text
config/backup.conf
```

### Solution

Check whether the file exists:

```bash
ls -l config/backup.conf
```

If it does not exist, create it:

```bash
nano config/backup.conf
```

Verify that the configuration contains:

```bash
SOURCE_DIR="$HOME/automated-backup-system/test-data"
BACKUP_DIR="$HOME/automated-backup-system/backups/archives"
LOG_FILE="$HOME/automated-backup-system/logs/backup.log"
RETENTION_DAYS=7
MINIMUM_FREE_SPACE=102400
```

---

# 3. Permission Denied

### Problem

You see:

```text
Permission denied
```

when executing a script.

### Cause

The script does not have execute permission.

### Solution

Run:

```bash
chmod +x scripts/*.sh
```

Verify:

```bash
ls -l scripts/
```

The scripts should have executable permissions similar to:

```text
-rwxr-xr-x
```

Then run:

```bash
./scripts/backup.sh
```

---

# 4. Source Directory Does Not Exist

### Problem

The backup fails with an error similar to:

```text
ERROR: Source directory does not exist
```

### Cause

The directory specified by `SOURCE_DIR` does not exist.

### Solution

Check the configured path:

```bash
grep SOURCE_DIR config/backup.conf
```

Check whether the directory exists:

```bash
ls -ld "$HOME/automated-backup-system/test-data"
```

If required, create it:

```bash
mkdir -p test-data
```

Add test file
