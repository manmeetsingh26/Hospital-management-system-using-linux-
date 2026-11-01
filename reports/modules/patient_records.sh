#!/usr/bin/env bash
patient_menu() {
    while true; do
        echo
        echo "--- PATIENT REGISTRATION & FILE MANAGEMENT ---"
        echo "1. Register patient"
        echo "2. Display all patient records"
        echo "3. Create a timestamped backup"
        echo "4. View first/last records"
        echo "5. Open patient file in nano (if installed)"
        echo "6. Return"
        read -r -p "Choice: " c
        case "$c" in
            1) register_patient ;;
            2) column -s, -t "$PATIENT_FILE" 2>/dev/null || cat "$PATIENT_FILE" ;;
            3)
                cp "$PATIENT_FILE" "$BACKUP_DIR/patients_$(date +%Y%m%d_%H%M%S).csv"
                echo "Backup saved in $BACKUP_DIR" ;;
            4) echo "First records:"; head -n 5 "$PATIENT_FILE"; echo; echo "Last records:"; tail -n 5 "$PATIENT_FILE" ;;
            5) if command -v nano >/dev/null 2>&1; then nano "$PATIENT_FILE"; else echo "nano is not installed."; fi ;;
            6) return ;;
            *) echo "Invalid choice." ;;
        esac
    done
}

register_patient() {
    echo "Enter patient details (use simple text; commas are not allowed)."
    read -r -p "Patient ID: " id
    read -r -p "Patient name: " name
    read -r -p "Age: " age
    read -r -p "Department: " dept
    read -r -p "Doctor: " doctor
    read -r -p "Phone: " phone
    read -r -p "Diagnosis/Reason: " diagnosis

    if [[ ! "$id" =~ ^[A-Za-z0-9_-]+$ ]]; then echo "Invalid ID."; return; fi
    if [[ ! "$age" =~ ^[0-9]{1,3}$ ]]; then echo "Age must be numeric."; return; fi
    if grep -q "^${id}," "$PATIENT_FILE"; then echo "Patient ID already exists."; return; fi
    for value in "$name" "$dept" "$doctor" "$phone" "$diagnosis"; do
        if [[ "$value" == *","* ]]; then echo "Commas are not allowed in fields."; return; fi
    done
    printf '%s,%s,%s,%s,%s,%s,%s\n' "$id" "$name" "$age" "$dept" "$doctor" "$phone" "$diagnosis" >> "$PATIENT_FILE"
    echo "Patient registered successfully."
}
