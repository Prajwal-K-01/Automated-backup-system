# Usage Guide

## 1. Overview

The **Automated Backup System** provides a simple Linux-based solution for creating, verifying, restoring, and managing backup archives.

The system uses Bash scripting and standard Linux utilities to automate:

* Backup creation
* TAR/GZIP compression
* SHA-256 integrity verification
* Backup restoration
* Backup retention and cleanup
* Logging
* Scheduled execution using Cron

---

# 2. Project Structure

The main operational components are:

```text
automated-backup-system/
├── backups/
│   └── archives/
├── config/
│   └── backup.conf
├── docs/
├── logs/
│   └── backup.log
├── scripts/
│   ├── backup.sh
│   ├── cleanup.sh
│   └── restore.sh
├── test-data/
├── reports/
└── README.md
```

---

# 3. Configuration

Before using the system, configure:

```bash
nano config/backup.conf
```

Example configuration:

```bash
SOURCE_DIR="$HOME/automated-backup-system/test-data"

BACKUP_DIR="$HOME/automated-backup-system/backups/archives"

LOG_FILE="$HOME/automated-backup-system/logs/backup.log"

RETENTION_DAYS=7

MINIMUM_FREE_SPACE=102400
```

### Configuration Parameters

| Parameter            | Description                               |
| -------------------- | ----------------------------------------- |
| `SOURCE_DIR`         | Directory containing the data to back up  |
| `BACKUP_DIR`         | Location where backup archives are stored |
| `LOG_FILE`           | Location of the backup activity log       |
| `RETENTION_DAYS`     | Number of days backups are retained       |
| `MINIMUM_FREE_SPACE` | Minimum required free disk space in KB    |

---

# 4. Make Scripts Executable

Before running the scripts, assign execute perm
