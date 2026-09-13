# System Architecture

## 1. Overview

The **Automated Backup System** is a Linux-based backup and recovery solution developed using Bash shell scripting.

The system is designed to automate the process of:

* Collecting important data
* Creating compressed backup archives
* Verifying backup integrity
* Managing backup retention
* Restoring backed-up data
* Recording operational logs
* Scheduling automated backup operations

The architecture follows a modular approach where configuration, backup, restoration, cleanup, logging, and scheduling are handled independently.

---

## 2. High-Level Architecture

```text
                    ┌─────────────────────┐
                    │     Source Data     │
                    │    test-data/       │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │     backup.sh       │
                    │ Backup Controller   │
                    └──────────┬──────────┘
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
                 ▼                           ▼
       ┌──────────────────┐        ┌──────────────────┐
       │ Disk Space Check │        │ Source Validation│
       └────────┬─────────┘        └────────┬─────────┘
                │                           │
                └─────────────┬─────────────┘
                              │
                              ▼
                    ┌─────────────────────┐
                    │     TAR + GZIP      │
                    │ Compression Process │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Backup Archive    │
                    │     .tar.gz         │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    SHA-256 Hash     │
                    │ Integrity Checksum  │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Backup Storage    │
                    │ backups/archives/   │
                    └──────────┬──────────┘
                               │
                    ┌──────────┴──────────┐
                    │                     │
                    ▼                     ▼
          ┌─────────────────┐    ┌─────────────────┐
          │   restore.sh    │    │   cleanup.sh    │
          │ Data Recovery   │    │ Retention Mgmt  │
          └────────┬────────┘    └─────────────────┘
                   │
                   ▼
          ┌─────────────────┐
          │ Restore Target  │
          │ restore-test/   │
          └─────────────────┘

                         ▲
                         │
                  ┌──────┴──────┐
                  │    Cron     │
                  │ Scheduler   │
                  └─────────────┘
```

---

## 3. Architecture Components

### 3.1 Source Data

**Location:**

```text
test-data/
```

This directory contains the files and directories that need to be backed up.

Example:

```text
test-data/
├── documents/
│   └── project.txt
├── logs/
│   └── application.log
└── projects/
    └── project1.txt
```

The source location is configurable through `backup.conf`.

---

### 3.2 Configuration Module

**File:**

```text
config/backup.conf
```

The configuration file stores the parameters required by the backup system.

Main configuration variables:

```bash
SOURCE_DIR
BACKUP_DIR
LOG_FILE
RETENTION_DAYS
MINIMUM_FREE_SPACE
```

This separates configuration from the application logic and makes the system easier to maintain.

---

### 3.3 Backup Controller

**Script:**

```text
scripts/backup.sh
```

This is the main component of the system.

Its responsibilities include:

1. Loading the configuration.
2. Creating required directories.
3. Generating a unique timestamp.
4. Validating the source directory.
5. Checking available disk space.
6. Creating the compressed backup.
7. Verifying that the backup was created.
8. Generating a SHA-256 checksum.
9. Recording backup information in the log.
10. Displaying the backup result.

---

### 3.4 Compression Module

The system uses:

```text
TAR + GZIP
```

TAR packages multiple files and directories into a single archive, while GZIP compresses the archive.

The resulting file has the format:

```text
backup_YYYY-MM-DD_HH-MM-SS.tar.gz
```

Example:

```text
backup_2026-09-13_12-30-01.tar.gz
```

This reduces storage requirements and makes the backup easier to transfer or manage.

---

### 3.5 Integrity Verification Module

After creating the backup, the system generates a SHA-256 checksum.

Example:

```text
backup_2026-09-13_12-30-01.tar.gz.sha256
```

The checksum can be verified using:

```bash
sha256sum -c backup_2026-09-13_12-30-01.tar.gz.sha256
```

Expected result:

```text
backup_2026-09-13_12-30-01.tar.gz: OK
```

SHA-256 helps detect accidental or unexpected modification of the backup archive.

---

### 3.6 Backup Storage

**Location:**

```text
backups/archives/
```

This directory stores the generated backup archives and checksum files.

Example:

```text
backups/archives/
├── backup_2026-09-13_12-30-01.tar.gz
└── backup_2026-09-13_12-30-01.tar.gz.sha256
```

Generated backup files are excluded from Git tracking through `.gitignore`.

---

### 3.7 Restore Module

**Script:**

```text
scripts/restore.sh
```

The restore module extracts a selected backup archive into a specified destination.

Before restoration, it checks the SHA-256 checksum when the corresponding checksum file is available.

Example:

```bash
./scripts/restore.sh \
backups/archives/backup_2026-09-13_12-30-01.tar.gz \
restore-test
```

The restored files are then available inside:

```text
restore-test/
```

---

### 3.8 Cleanup Module

**Script:**

```text
scripts/cleanup.sh
```

The cleanup module manages backup retention.

The retention period is defined in:

```text
config/backup.conf
```

Example:

```bash
RETENTION_DAYS=7
```

Backups older than the configured retention period are automatically removed.

This prevents unlimited growth of backup storage.

---

### 3.9 Logging Module

**Log file:**

```text
logs/backup.log
```

The system records important events such as:

* Backup start time
* Source directory
* Disk-space validation
* Backup creation
* Checksum generation
* Backup size
* Backup completion
* Cleanup operations

Example:

```text
========================================
Backup started: Sun Sep 13 12:30:01 IST 2026
Source directory:
```
