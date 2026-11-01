#!/usr/bin/env bash
# This module is sourced by main.sh after the other modules.
generate_full_report() {
    out="$REPORT_DIR/hospital_system_report_$(date +%Y%m%d_%H%M%S).txt"
    {
        echo "HOSPITAL MANAGEMENT SYSTEM - ADMINISTRATION REPORT"
        echo "Generated: $(date)"
        echo "=============================================="
        echo
        echo "OPERATING SYSTEM"; cat /etc/os-release 2>/dev/null
        echo
        echo "KERNEL"; uname -r
        echo
        echo "UPTIME"; uptime
        echo
        echo "DISK USAGE"; df -h
        echo
        echo "MEMORY AND SWAP"; free -h
        echo
        echo "PATIENT RECORD COUNT (excluding header)"
        tail -n +2 "$PATIENT_FILE" | wc -l
        echo
        echo "SELINUX MODE"
        if command -v getenforce >/dev/null 2>&1; then getenforce; else echo "Not available"; fi
        echo
        echo "RECENT SYSTEM ERRORS"
        journalctl -p err -n 10 --no-pager 2>&1
    } > "$out"
    echo "Complete report saved to: $out"
}
