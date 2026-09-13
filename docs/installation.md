# Installation Guide

## 1. Overview

This guide explains how to install, configure, test, and run the **Automated Backup System** on a Linux system.

The project is designed for Linux distributions such as:

* RHEL
* Rocky Linux
* AlmaLinux
* CentOS Stream

The system uses Bash scripting, TAR, GZIP, SHA-256 and Cron.

---

## 2. System Requirements

### Operating System

A Linux-based operating system is recommended.

Tested environment:

```text
RHEL / Red Hat Enterprise Linux
```

### Required Software

The following utilities are required:

```text
Bash
TAR
GZIP
Coreutils
Cron
Git
```

Most of these utilities are available by default on RHEL-based systems.

---

## 3. Verify Required Tools

Check Bash:

```bash
bash --version
```

Check TAR:

```bash
tar --version
```

Check GZIP:

```bash
gzip --version
```

Check SHA-256:

```bash
sha256sum --version
```

Check Git:

```bash
git --version
```

Check Cron service:

```bash
systemctl status crond
```

If all required commands are available, the system is ready for installation.

---

## 4. Clone the Repository

Clone the project from GitHub:

```bash
git clone https://github.com/YOUR_USERNAME/automated-backup-system.git
```

Move into the project directory:

```bash
cd automated-backup-system
```

Verify the project structure:

```bash
ls -la
```

Expected structure:

```text
backups
config
docs
logs
reports
screenshots
scripts
test-data
.gitignore
LICENSE
README.md
```

---

## 5. Configure Script Permissions

The backup scripts need execute permissions.

Run:

```bash
chmod +x scripts/*.sh
```

Verify the permissions:

```bash
ls -l scripts/
```

Expected output should show executable permissions:

```text
-rwxr-xr-x backup.sh
-rwxr-xr-x cleanup.sh
```
