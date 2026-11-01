#!/usr/bin/env bash
storage_menu() {
    while true; do
        echo
        echo "--- STORAGE, BACKUP & SWAP INFORMATION ---"
        echo "1. Show disk usage"
        echo "2. Show mounted file systems"
        echo "3. Show memory and swap"
        echo "4. Create a lab workspace"
        echo "5. Create a backup of patient records"
        echo "6. Show directory tree (if installed)"
        echo "7. Return"
        read -r -p "Choice: " c
        case "$c" in
            1) df -h ;;
            2) findmnt 2>/dev/null || mount ;;
            3) free -h; swapon --show 2>/dev/null || true ;;
            4)
                mkdir -p "$BASE_DIR/hospital_workspace"/{patients,doctors,medical_reports,archive}
                touch "$BASE_DIR/hospital_workspace/README.txt"
                echo "Hospital workspace created."
                pwd
                ls -la "$BASE_DIR/hospital_workspace" ;;
            5)
                cp "$PATIENT_FILE" "$BACKUP_DIR/patients_manual_$(date +%Y%m%d_%H%M%S).csv"
                echo "Patient data backup created." ;;
            6) if command -v tree >/dev/null 2>&1; then tree "$BASE_DIR"; else find "$BASE_DIR" -maxdepth 2 -print; fi ;;
            7) return ;;
            *) echo "Invalid choice." ;;
        esac
    done
}
