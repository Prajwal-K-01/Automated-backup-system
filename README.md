# 🛡️ Automated Backup System

### Reliable • Verifiable • Recoverable • Automated

> **A production-inspired Linux backup and recovery automation system built with Bash, TAR/GZIP, SHA-256 and Cron.**

<p align="center">

![Linux](https://img.shields.io/badge/Linux-RHEL-000000?style=flat-square\&logo=linux\&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Automation-4EAA25?style=flat-square\&logo=gnubash\&logoColor=white)
![Cron](https://img.shields.io/badge/Cron-Scheduling-2F80ED?style=flat-square)
![SHA-256](https://img.shields.io/badge/SHA--256-Integrity-8E44AD?style=flat-square)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=flat-square\&logo=git\&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-F7DF1E?style=flat-square)

</p>

---

## ⚡ Why This Project?

Data loss can happen because of:

* accidental deletion
* system failures
* corrupted files
* insufficient storage
* configuration mistakes
* operational errors

A backup is only useful if it can be **trusted and restored**.

This project goes beyond simply copying files.

It implements a complete backup lifecycle:

```text
        DATA
         │
         ▼
   ┌─────────────┐
   │   VALIDATE  │
   └──────┬──────┘
          │
          ▼
   ┌─────────────┐
   │  COMPRESS   │
   │ TAR + GZIP  │
   └──────┬──────┘
          │
          ▼
   ┌─────────────┐
   │   VERIFY    │
   │   SHA-256   │
   └──────┬──────┘
          │
          ▼
   ┌─────────────┐
   │    STORE    │
   └──────┬──────┘
          │
      ┌───┴────┐
      ▼        ▼
   RESTORE   CLEANUP
```

> **The goal is simple: automate backups, verify integrity, recover data, and eliminate repetitive manual operations.**

---

# 🎯 Project Mission

The **Automated Backup System** is designed as a practical Linux/DevOps project that demonstrates how system administrators and DevOps engineers can automate repetitive operational tasks using shell scripting.

### Core objectives

```text
✓ Automate backup creation
✓ Compress backup data
✓ Verify data integrity
✓ Validate available disk space
✓ Restore data when required
✓ Remove expired backups
✓ Maintain operational logs
✓ Schedule recurring operations
✓ Follow maintainable project structure
```

---

# 🧩 Core Capabilities

| Capability         | Implementation            |
| ------------------ | ------------------------- |
| 📦 Backup          | Bash + TAR                |
| 🗜️ Compression    | GZIP                      |
| 🔐 Integrity       | SHA-256                   |
| ♻️ Recovery        | TAR extraction            |
| 🧹 Retention       | `find` + retention policy |
| 💾 Storage Check   | `df`                      |
| 📋 Logging         | Bash logging              |
| ⏰ Scheduling       | Cron                      |
| ⚙️ Configuration   | `backup.conf`             |
| 🧪 Testing         | Dedicated test data       |
| 🌿 Version Control | Git                       |

---

# 🏗️ Architecture

```text
                         ┌─────────────────────┐
                         │      TEST DATA      │
                         │     test-data/      │
                         └──────────┬──────────┘
                                    │
                                    ▼
                         ┌─────────────────────┐
                         │      backup.sh      │
                         │  Backup Controller  │
                         └──────────┬──────────┘
                                    │
                       ┌────────────┴────────────┐
                       │                         │
                       ▼                         ▼
              ┌─────────────────┐      ┌─────────────────┐
              │ Source          │      │ Disk Space      │
              │ Validation      │      │ Va
```
