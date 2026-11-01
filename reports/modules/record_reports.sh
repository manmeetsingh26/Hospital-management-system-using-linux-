#!/usr/bin/env bash
reports_menu() {
    while true; do
        echo
        echo "--- PATIENT SEARCH & FILTER REPORTS ---"
        echo "1. Search patient name"
        echo "2. Filter by department"
        echo "3. Search patient ID using start-of-line regex"
        echo "4. Display records matching a word (case-insensitive)"
        echo "5. Show only selected columns"
        echo "6. Sort records by patient name"
        echo "7. Find duplicate records"
        echo "8. Replace department text into a new report"
        echo "9. Return"
        read -r -p "Choice: " c
        case "$c" in
            1) read -r -p "Name: " n; grep -i -- "$n" "$PATIENT_FILE" ;;
            2) read -r -p "Department: " d; grep -i -- "$d" "$PATIENT_FILE" ;;
            3) read -r -p "Patient ID: " id; grep "^${id}," "$PATIENT_FILE" ;;
            4) read -r -p "Search text: " t; grep -in -- "$t" "$PATIENT_FILE" ;;
            5)
                echo "1=ID 2=Name 3=Age 4=Department 5=Doctor 6=Phone 7=Diagnosis"
                read -r -p "Column number: " f
                if [[ "$f" =~ ^[1-7]$ ]]; then cut -d, -f "$f" "$PATIENT_FILE"; else echo "Choose 1 to 7."; fi ;;
            6) (head -n 1 "$PATIENT_FILE"; tail -n +2 "$PATIENT_FILE" | sort -t, -k2,2) ;;
            7) echo "Duplicate rows (if any):"; tail -n +2 "$PATIENT_FILE" | sort | uniq -d ;;
            8)
                read -r -p "Text to replace: " old
                read -r -p "Replacement text: " new
                # Write to a separate report; original patient data is not modified.
                sed "s/${old}/${new}/g" "$PATIENT_FILE" > "$REPORT_DIR/updated_patient_report.csv"
                echo "Saved $REPORT_DIR/updated_patient_report.csv" ;;
            9) return ;;
            *) echo "Invalid choice." ;;
        esac
    done
}
