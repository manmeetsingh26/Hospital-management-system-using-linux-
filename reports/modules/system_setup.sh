#!/usr/bin/env bash
system_setup_menu() {
    while true; do
        echo
        echo "--- SYSTEM INFORMATION & PACKAGE TOOLS ---"
        echo "1. Show Linux distribution"
        echo "2. Show kernel and boot target"
        echo "3. Show recent boot logs"
        echo "4. Show package manager and repositories"
        echo "5. Search for lab tools"
        echo "6. Install useful tools (requires sudo)"
        echo "7. Return"
        read -r -p "Choice: " c
        case "$c" in
            1) cat /etc/os-release ;;
            2) uname -r; systemctl get-default 2>/dev/null || echo "systemctl unavailable" ;;
            3) journalctl -b -n 30 --no-pager 2>/dev/null || echo "Journal logs unavailable or permission denied." ;;
            4)
                if command -v dnf >/dev/null 2>&1; then dnf --version; dnf repolist
                elif command -v yum >/dev/null 2>&1; then yum --version; yum repolist
                elif command -v apt >/dev/null 2>&1; then apt --version; echo "APT repositories are configured in /etc/apt/sources.list and /etc/apt/sources.list.d/"
                else echo "No supported package manager detected."; fi ;;
            5)
                read -r -p "Package to search (nano/vim/tree/wget): " pkg
                if command -v dnf >/dev/null 2>&1; then dnf search "$pkg"
                elif command -v yum >/dev/null 2>&1; then yum search "$pkg"
                elif command -v apt >/dev/null 2>&1; then apt search "$pkg"
                else echo "Package manager not found."; fi ;;
            6)
                echo "This installs nano, vim, tree and wget."
                read -r -p "Continue? Type YES: " confirm
                if [[ "$confirm" == "YES" ]]; then
                    if command -v dnf >/dev/null 2>&1; then sudo dnf install nano vim tree wget -y
                    elif command -v yum >/dev/null 2>&1; then sudo yum install nano vim tree wget -y
                    elif command -v apt >/dev/null 2>&1; then sudo apt update && sudo apt install nano vim tree wget -y
                    else echo "No supported package manager."; fi
                else echo "Cancelled."; fi ;;
            7) return ;;
            *) echo "Invalid choice." ;;
        esac
    done
}
