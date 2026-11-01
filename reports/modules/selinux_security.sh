#!/usr/bin/env bash
selinux_menu() {
    while true; do
        echo
        echo "--- SELINUX SECURITY ---"
        echo "1. Show SELinux status"
        echo "2. Show current SELinux mode"
        echo "3. Create demo hospital web directory and page"
        echo "4. Show web file SELinux context"
        echo "5. Restore default SELinux context"
        echo "6. Return"
        read -r -p "Choice: " c
        case "$c" in
            1) if command -v sestatus >/dev/null 2>&1; then sestatus; else echo "SELinux tools not installed (common on Ubuntu)."; fi ;;
            2) if command -v getenforce >/dev/null 2>&1; then getenforce; else echo "getenforce unavailable."; fi ;;
            3)
                echo "This creates /var/www/html/hospital-demo/index.html."
                read -r -p "Continue? Type YES: " confirm
                if [[ "$confirm" == "YES" ]]; then
                    sudo mkdir -p /var/www/html/hospital-demo
                    echo "Hospital Information Portal - Demo Page" | sudo tee /var/www/html/hospital-demo/index.html
                    echo "Created demo web page."
                else echo "Cancelled."; fi ;;
            4) ls -lZ /var/www/html/hospital-demo/index.html 2>&1 || echo "Demo page not created." ;;
            5)
                if [[ -e /var/www/html/hospital-demo ]]; then
                    sudo restorecon -Rv /var/www/html/hospital-demo
                else echo "Create the demo directory first."; fi ;;
            6) return ;;
            *) echo "Invalid choice." ;;
        esac
    done
}
