#!/usr/bin/env bash
# Hospital Management System - Linux Administration Mini Project
set -u
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
export BASE_DIR
export DATA_DIR="$BASE_DIR/data"
export REPORT_DIR="$BASE_DIR/reports"
export BACKUP_DIR="$BASE_DIR/backups"
export PATIENT_FILE="$DATA_DIR/patients.csv"

for module in system_setup patient_records access_control record_reports monitoring selinux_security storage full_report; do
    # shellcheck source=/dev/null
    source "$BASE_DIR/modules/${module}.sh"
done

mkdir -p "$DATA_DIR" "$REPORT_DIR" "$BACKUP_DIR"
if [[ ! -f "$PATIENT_FILE" ]]; then
    printf 'PatientID,Name,Age,Department,Doctor,Phone,Diagnosis\n' > "$PATIENT_FILE"
fi

pause() { echo; read -r -p "Press Enter to continue..." _; }

while true; do
    clear 2>/dev/null || true
    echo "=================================================="
    echo "       HOSPITAL MANAGEMENT SYSTEM (HMS)"
    echo "       Linux Administration Mini Project"
    echo "=================================================="
    echo "1. System information & package tools"
    echo "2. Patient registration and file management"
    echo "3. Doctor/staff users, groups and permissions"
    echo "4. Search, filter and sort patient records"
    echo "5. System logs and troubleshooting report"
    echo "6. SELinux security status and web directory"
    echo "7. Storage, backup and swap information"
    echo "8. Generate complete hospital administration report"
    echo "9. Exit"
    echo "--------------------------------------------------"
    read -r -p "Enter your choice: " choice
    case "$choice" in
        1) system_setup_menu; pause ;;
        2) patient_menu; pause ;;
        3) access_control_menu; pause ;;
        4) reports_menu; pause ;;
        5) monitoring_menu; pause ;;
        6) selinux_menu; pause ;;
        7) storage_menu; pause ;;
        8) generate_full_report; pause ;;
        9) echo "Thank you for using HMS."; exit 0 ;;
        *) echo "Invalid choice."; pause ;;
    esac
done
