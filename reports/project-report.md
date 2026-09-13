# Automated Backup System

## Project Report

---

## 1. Project Overview

The **Automated Backup System** is a Linux-based backup automation project developed using **Bash scripting and standard Linux utilities**.

The system automates the complete backup lifecycle, including backup creation, compression, integrity verification, restoration, retention management, logging, and scheduled execution.

The project is designed to demonstrate practical **Linux administration, shell scripting, system automation, data protection, and backup recovery** concepts.

---

## 2. Problem Statement

Manual backup processes are often inconsistent, time-consuming, and dependent on user intervention. Important data may be lost when backups are not created regularly or when backup files become corrupted.

The project addresses these challenges by providing an automated solution that can:

* Create backups automatically.
* Compress backup data.
* Verify backup integrity.
* Restore backed-up data.
* Remove outdated backups.
* Maintain backup activity logs.
* Schedule recurring backup operations.

---

## 3. Objectives

The primary objectives of the project are:

1. Develop a reliable Linux-based backup system.
2. Automate backup creation using Bash.
3. Compress data using TAR and GZIP.
4. Generate SHA-256 checksums for integrity verification.
5. Provide a simple backup restoration mechanism.
6. Implement automatic backup retention and cleanup.
7. Maintain operational logs.
8. Validate available disk space before backup creation.
9. Automate backup execution using Cron.
10. Build a modular project suitable for future cloud integration.

---

## 4. Technologies Used

| Technology               | Purpose                               |
| ------------------------ | ------------------------------------- |
| Red Hat Enterprise Linux | Development and execution environment |
| Bash                     | Automation and scripting              |
| TAR                      | File archiving                        |
| GZIP                     | Data compression                      |
| SHA-256                  | Data integrity verification           |
| Cron                     | Scheduled automation                  |
| `df`                     | Disk-space verification               |
| `find`                   | Backup cleanup                        |
| Git                      | Version control                       |
| GitHub                   | Project repository                    |

---

## 5. System Architecture

```text
                    ┌─────────────────────┐
                    │     Source Data     │
                    │     test-data/      │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │      backup.sh      │
                    │  Backup Controller  │
                    └──────────┬──────────┘
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
                 ▼                           ▼
        ┌──────────────────┐       ┌──────────────────┐
        │ Source Validation│       │  Disk Space Check│
        └────────┬─────────┘       └────────┬─────────┘
                 │                          │
                 └─────────────┬────────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │     TAR + GZIP      │
                    │    Compression      │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Backup Archive    │
                    │      .tar.gz        │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │      SHA-256        │
                    │ Integrity Checksum  │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Backup Storage    │
                    │  backups/archives/  │
                    └──────────┬──────────┘
                               │
                     ┌─────────┴─────────┐
                     │                   │
                     ▼                   ▼
              ┌──────────────┐    ┌──────────────┐
              │  restore.sh  │    │  cleanup.sh  │
              │ Data Recovery│    │ Retention Mgmt│
              └──────────────┘    └──────────────┘
                              
                              ▲
                              │
                       ┌──────┴──────┐
                       │    Cron     │
                       │  Scheduler  │
                       └─────────────┘
```

---

## 6. Project Structure

```text
automated-backup-system/
│
├── backups/
│   └── archives/
│
├── config/
│   └── backup.conf
│
├── docs/
│   ├── architecture.md
│   ├── installation.md
│   ├── usage.md
│   └── troubleshooting.md
│
├── logs/
│   └── backup.log
│
├── reports/
│   └── project-report.md
│
├── screenshots/
│
├── scripts/
│   ├── backup.sh
│   ├── cleanup.sh
│   └── restore.sh
│
├── test-data/
│   ├── documents/
│   ├── logs/
│   └── projects/
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## 7. Major Components

### 7.1 Configuration Module

**File:**

```text
config/backup.conf
```

The configuration module stores important system parameters such as:

```bash
SOURCE_DIR
BACKUP_DIR
LOG_FILE
RETENTION_DAYS
MINIMUM_FREE_SPACE
```

Separating configuration from the main scripts makes the project easier to maintain and customize.

---

### 7.2 Backup Module

**File:**

```text
scripts/backup.sh
```

The backup script is the main controller of the system.

It performs:

1. Configuration validation.
2. Source directory verification.
3. Backup directory creation.
4. Disk-space validation.
5. TAR/GZIP archive creation.
6. SHA-256 checksum generation.
7. Backup information logging.
8. Successful completion reporting.

---

### 7.3 Restore Module

**File:**

```text
scripts/restore.sh
```

The restore script allows users to recover files from a selected backup archive.

Before restoration, it verifies the checksum when a corresponding checksum file is available.

Example:

```bash
./scripts/restore.sh \
backups/archives/backup_YYYY-MM-DD_HH-MM-SS.tar.gz \
restore-test
```

---

### 7.4 Cleanup Module

**File:**

```text
scripts/cleanup.sh
```

The cleanup script manages backup retention.

It identifies backup files older than the configured retention period and removes them.

Example:

```bash
RETENTION_DAYS=7
```

This prevents unlimited backup accumulation.

---

### 7.5 Logging Module

**File:**

```text
logs/backup.log
```

The system records important operational information such as:

* Backup start time
* Source directory
* Disk-space status
* Archive creation
* Checksum generation
* Backup completion
* Cleanup operations

Logs can be viewed using:

```bash
tail -30 logs/backup.log
```

---

## 8. Backup Workflow

The backup workflow is:

```text
Source Data
     ↓
Load Configuration
     ↓
Validate Source Directory
     ↓
Check Available Disk Space
     ↓
Create TAR.GZ Archive
     ↓
Generate SHA-256 Checksum
     ↓
Store Backup
     ↓
Write Log
     ↓
Backup Completed
```

The timestamp-based naming system prevents backup files from overwriting one another.

Example:

```text
backup_2026-09-13_12-30-01.tar.gz
```

---

## 9. Data Integrity Verification

The project uses the **SHA-256 cryptographic hash algorithm** to verify backup integrity.

When a backup is created, a checksum file is generated:

```text
backup_2026-09-13_12-30-01.tar.gz.sha256
```

The checksum can be verified using:

```bash
sha256sum -c backups/archives/backup_2026-09-13_12-30-01.tar.gz.sha256
```

Successful verification:

```text
backup_2026-09-13_12-30-01.tar.gz: OK
```

This helps detect accidental corruption or modification of the backup archive.

---

## 10. Restore Workflow

The restoration process follows:

```text
Select Backup
     ↓
Check Backup File
     ↓
Verify SHA-256 Checksum
     ↓
Create Restore Directory
     ↓
Extract TAR.GZ Archive
     ↓
Verify Restored Files
```

Example:

```bash
mkdir -p restore-test

./scripts/restore.sh \
backups/archives/<backup-file>.tar.gz \
restore-test
```

The restored files can be checked using:

```bash
find restore-test -type f
```

---

## 11. Backup Retention

The system implements a configurable backup retention policy.

The default configuration is:

```bash
RETENTION_DAYS=7
```

The cleanup script uses the Linux `find` command to identify outdated backup archives.

Command:

```bash
./scripts/cleanup.sh
```

This ensures that old backups do not continuously consume storage space.

---

## 12. Disk Space Validation

Before creating a backup, the system checks available disk space using:

```bash
df
```

The minimum required space is configured using:

```bash
MINIMUM_FREE_SPACE=102400
```

If available space falls below the configured threshold, the backup operation is stopped.

This reduces the risk of backup failures caused by insufficient storage.

---

## 13. Automation Using Cron

Cron is used to automate recurring backup operations.

Example:

```cron
0 2 * * * /root/automated-backup-system/scripts/backup.sh
30 2 * * * /root/automated-backup-system/scripts/cleanup.sh
```

The schedule performs:

| Time     | Operation |
| -------- | --------- |
| 02:00 AM | Backup    |
| 02:30 AM | Cleanup   |

Cron jobs can be verified using:

```bash
crontab -l
```

The Cron service can be checked using:

```bash
systemctl status crond
```

---

## 14. Testing and Validation

The system was tested using sample data stored in:

```text
test-data/
```

### Test Case 1 — Backup Creation

Command:

```bash
./scripts/backup.sh
```

Expected result:

```text
BACKUP COMPLETED SUCCESSFULLY
```

---

### Test Case 2 — Backup File Verification

Command:

```bash
ls -lh backups/archives/
```

Expected result:

```text
backup_<timestamp>.tar.gz
backup_<timestamp>.tar.gz.sha256
```

---

### Test Case 3 — Checksum Verification

Command:

```bash
sha256sum -c backups/archives/<backup-file>.tar.gz.sha256
```

Expected result:

```text
OK
```

---

### Test Case 4 — Archive Inspection

Command:

```bash
tar -tzf backups/archives/<backup-file>.tar.gz
```

Expected result:

The contents of the backup archive are displayed.

---

### Test Case 5 — Restore Operation

Command:

```bash
./scripts/restore.sh \
backups/archives/<backup-file>.tar.gz \
restore-test
```

Expected result:

```text
RESTORE COMPLETED SUCCESSFULLY
```

---

### Test Case 6 — Restored Data Verification

Command:

```bash
find restore-test -type f
```

Expected result:

The original test files are present in the restore location.

---

### Test Case 7 — Cleanup

Command:

```bash
./scripts/cleanup.sh
```

Expected result:

Backups older than the configured retention period are removed.

---

### Test Case 8 — Log Verification

Command:

```bash
tail -30 logs/backup.log
```

Expected result:

Backup and cleanup activities are recorded.

---

## 15. Results

The project successfully implements a functional local backup and recovery workflow.

| Feature                       | Result      |
| ----------------------------- | ----------- |
| Backup creation               | Successful  |
| TAR/GZIP compression          | Successful  |
| SHA-256 checksum generation   | Successful  |
| Backup integrity verification | Successful  |
| Backup restoration            | Successful  |
| Retention-based cleanup       | Successful  |
| Disk-space validation         | Successful  |
| Logging                       | Successful  |
| Cron automation               | Implemented |
| Git version control           | Implemented |

The system provides a lightweight and modular approach to backup automation on Linux.

---

## 16. Reliability Features

The following mechanisms improve system reliability:

* Source directory validation
* Disk-space validation
* SHA-256 integrity verification
* Timestamp-based backup naming
* Backup retention
* Restore verification
* Operational logging
* Automated scheduling

These features help reduce manual intervention and improve the consistency of backup operations.

---

## 17. Limitations

The current version has the following limitations:

1. Backups are stored locally.
2. Backup encryption is not implemented.
3. Incremental backups are not supported.
4. Remote backup replication is not implemented.
5. No graphical monitoring dashboard is included.
6. No email or messaging notification system is included.
7. Disaster recovery is limited to the available backup storage.

---

## 18. Future Enhancements

The project can be extended with the following features:

### Cloud Backup

Integrate with:

* AWS S3
* Azure Blob Storage
* Google Cloud Storage

### Encryption

Implement encrypted backup archives using technologies such as:

```text
GPG
OpenSSL
```

### Incremental Backups

Implement incremental and differential backup strategies to reduce:

* Storage requirements
* Backup time
* Data transfer

### Remote Backup

Support remote backup using:

```text
SSH
SCP
Rsync
```

### Notifications

Add notifications for:

* Successful backups
* Failed backups
* Low disk space
* Checksum failures

### Monitoring Dashboard

A future dashboard could display:

* Backup status
* Backup history
* Storage usage
* Last successful backup
* Failed backup operations
* Restore history

---

## 19. Security Considerations

The current project provides basic integrity protection through SHA-256 verification.

For production deployment, additional security controls should be implemented:

* Encrypt backup archives.
* Restrict backup directory permissions.
* Use secure remote storage.
* Apply least-privilege access.
* Protect backup credentials.
* Maintain off-site backup copies.
* Monitor failed backup attempts.
* Regularly test disaster recovery procedures.

---

## 20. Skills Demonstrated

This project demonstrates practical knowledge of:

* Linux administration
* Red Hat Enterprise Linux
* Bash scripting
* File management
* Directory management
* Linux permissions
* TAR/GZIP
* SHA-256 hashing
* Disk-space management
* Cron scheduling
* Log management
* Backup and recovery
* Git
* GitHub
* System automation
* Infrastructure reliability

---

## 21. Project Learning Outcomes

Through this project, the following practical skills were developed:

1. Writing modular Bash scripts.
2. Automating repetitive Linux administration tasks.
3. Working with Linux file systems.
4. Managing backup archives.
5. Implementing integrity verification.
6. Creating automated retention policies.
7. Scheduling tasks using Cron.
8. Troubleshooting Linux automation scripts.
9. Managing project files using Git.
10. Designing a project structure suitable for professional development.

---

## 22. DevOps Relevance

The project provides a foundation for several important DevOps concepts.

### Automation

Manual operations are replaced with repeatable Bash scripts.

### Reliability

Backup verification and restore functionality improve data reliability.

### Scheduling

Cron enables unattended execution of recurring tasks.

### Monitoring

Log files provide visibility into system operations.

### Infrastructure Management

The project demonstrates how Linux utilities can be combined to automate infrastructure-related tasks.

### Future Cloud Integration

The architecture can be extended to integrate with cloud storage and cloud-based disaster recovery systems.

---

## 23. Conclusion

The **Automated Backup System** successfully demonstrates how Linux utilities and Bash scripting can be combined to create a practical backup automation solution.

The project provides a complete workflow covering:

```text
Backup
   ↓
Compression
   ↓
Integrity Verification
   ↓
Storage
   ↓
Restore
   ↓
Cleanup
   ↓
Automation
   ↓
Logging
```

The modular architecture makes the project easy to understand, maintain, and extend.

Future integration with cloud storage, encryption, incremental backups, remote replication, monitoring, and notifications can transform the project into a more advanced enterprise backup and disaster recovery solution.

---

## 24. Author

**Prajwal K**

**Aspiring Cloud & DevOps Engineer**

### Areas of Interest

* Cloud Computing
* Linux
* DevOps
* Infrastructure Automation
* AWS
* Microsoft Azure
* Google Cloud
* Docker
* Kubernetes
* Terraform

---

## 25. License

This project is licensed under the **MIT License**.

See the `LICENSE` file for complete license information.

