#!/usr/bin/env bash
access_control_menu() {
    while true; do
        echo
        echo "--- DOCTOR / STAFF USERS, GROUPS & PERMISSIONS ---"
        echo "1. Show current user and identity"
        echo "2. Create hospital department group"
        echo "3. Create a staff account (Linux user)"
        echo "4. Add existing user to a group"
        echo "5. Create shared department folder"
        echo "6. Show folder permissions"
        echo "7. Grant ACL read access to a user"
        echo "8. View ACL"
        echo "9. Return"
        read -r -p "Choice: " c
        case "$c" in
            1) id; whoami; groups ;;
            2)
                read -r -p "New group name (e.g. doctors): " g
                if [[ "$g" =~ ^[a-z_][a-z0-9_-]*$ ]]; then sudo groupadd "$g"; else echo "Invalid group name."; fi ;;
            3)
                read -r -p "New username (e.g. doctor1): " u
                if [[ "$u" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
                    sudo useradd -m "$u" && sudo passwd "$u"
                else echo "Invalid username."; fi ;;
            4)
                read -r -p "Existing username: " u
                read -r -p "Existing group: " g
                sudo usermod -aG "$g" "$u" ;;
            5)
                read -r -p "Department folder name (e.g. cardiology): " d
                if [[ "$d" =~ ^[a-zA-Z0-9_-]+$ ]]; then
                    sudo mkdir -p "/srv/hospital/$d"
                    read -r -p "Group that should own this folder: " g
                    sudo chgrp "$g" "/srv/hospital/$d" && sudo chmod 2770 "/srv/hospital/$d"
                    echo "Created /srv/hospital/$d (setgid group-sharing permission)."
                else echo "Invalid folder name."; fi ;;
            6)
                read -r -p "Folder path: " p
                ls -ld "$p" 2>/dev/null || echo "Folder not found." ;;
            7)
                read -r -p "File path: " p
                read -r -p "Username to grant read access: " u
                sudo setfacl -m "u:$u:r" "$p" ;;
            8)
                read -r -p "File or folder path: " p
                getfacl "$p" 2>/dev/null || echo "ACL tool unavailable or path not found." ;;
            9) return ;;
            *) echo "Invalid choice." ;;
        esac
    done
}
