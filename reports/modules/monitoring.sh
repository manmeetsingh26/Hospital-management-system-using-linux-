#!/usr/bin/env bash
monitoring_menu() {
    while true; do
        echo
        echo "--- SYSTEM LOGS & TROUBLESHOOTING ---"
        echo "1. Recent system logs"
        echo "2. Current boot logs"
        echo "3. Recent error logs"
        echo "4. Kernel logs"
        echo "5. Follow live logs (Ctrl+C to stop)"
        echo "6. Logs for a service"
        echo "7. Save troubleshooting report"
        echo "8. Return"
        read -r -p "Choice: " c
        case "$c" in
            1) journalctl -n 30 --no-pager 2>&1 ;;
            2) journalctl -b -n 50 --no-pager 2>&1 ;;
            3) journalctl -p err -n 30 --no-pager 2>&1 ;;
            4) journalctl -k -n 30 --no-pager 2>&1; dmesg 2>/dev/null | tail -n 15 ;;
            5) journalctl -f ;;
            6)
                read -r -p "Service name (e.g. sshd, ssh, NetworkManager): " s
                journalctl -u "$s" -n 40 --no-pager 2>&1 ;;
            7)
                out="$REPORT_DIR/troubleshooting_$(date +%Y%m%d_%H%M%S).txt"
                {
                    echo "HOSPITAL SERVER TROUBLESHOOTING REPORT"
                    echo "Generated: $(date)"
                    echo
                    echo "UPTIME"; uptime
                    echo
                    echo "RECENT ERRORS"; journalctl -p err -n 20 --no-pager 2>&1
                    echo
                    echo "RECENT KERNEL MESSAGES"; journalctl -k -n 20 --no-pager 2>&1
                } > "$out"
                echo "Report saved: $out" ;;
            8) return ;;
            *) echo "Invalid choice." ;;
        esac
    done
}
