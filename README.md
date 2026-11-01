# Hospital Management System (HMS)

A terminal-based Linux administration mini project built with Bash scripting. It demonstrates concepts from six Linux lab experiments through a hospital scenario.

## Features

1. System information, boot details, package manager checks and optional installation of nano/vim/tree/wget.
2. Patient registration, CSV record storage, viewing, backups and file operations.
3. Linux staff users, department groups, shared folders, permissions and ACL.
4. Patient search, department filtering, regular expressions, `grep`, `sed`, `cut`, `sort` and `uniq`.
5. System, boot, kernel, service and error logs using `journalctl`; troubleshooting reports.
6. SELinux status, file contexts and `restorecon` for a demo web directory.
7. Disk, mount, memory and swap information plus hospital workspace creation.
8. Complete administration report.

## Requirements

- Bash
- Linux system (Fedora/Rocky/RHEL recommended; Ubuntu can run most features)
- `sudo` for account, group, ACL, package and web-directory administration tasks
- Optional: `nano`, `vim`, `tree`, `acl`, `policycoreutils`

## Run

Open a terminal in this project directory:

```bash
chmod +x main.sh
./main.sh
```

Some log commands may require elevated permissions. If logs are restricted, run the individual command with `sudo` or configure your system's journal permissions.

## Safety notes

- Use a virtual machine for experiments that create users/groups or change system permissions.
- The project does not automatically delete Linux users, remove packages, format disks, create loop devices, or change SELinux enforcement mode.
- Patient information is fictional demo data. Do not enter real patient/medical information into this educational project.
- The CSV file is a simple learning format, not a secure medical database. It is not suitable for real hospital use.
- The SELinux demo creates `/var/www/html/hospital-demo/` only after confirmation.
- The package installer runs only after explicit confirmation.

## Project structure

```text
Hospital-Management-System/
├── main.sh
├── modules/
│   ├── system_setup.sh
│   ├── patient_records.sh
│   ├── access_control.sh
│   ├── record_reports.sh
│   ├── monitoring.sh
│   ├── selinux_security.sh
│   ├── storage.sh
│   └── full_report.sh
├── data/
│   └── patients.csv
├── reports/
└── backups/
```

## Linux experiment mapping

| Lab experiment | Project module |
|---|---|
| 1. Linux setup and packages | `system_setup.sh` |
| 2. Files, storage and swap | `patient_records.sh`, `storage.sh` |
| 3. Users, groups, permissions, ACL | `access_control.sh` |
| 4. Filters and regular expressions | `record_reports.sh` |
| 5. Logs and troubleshooting | `monitoring.sh` |
| 6. SELinux basics | `selinux_security.sh` |

## Academic purpose

This is an educational demonstration of Linux system administration using a fictional hospital workflow. It is not a production hospital information system.
