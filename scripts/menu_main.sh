#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

menu_main() {
    local MAINOPTS
    MAINOPTS=()
    MAINOPTS+=("Configuration " "Setup and start applications")
    MAINOPTS+=("Install Dependencies " "Latest version of Docker and Docker-Compose")
    MAINOPTS+=("Update DockSTARTer " "Get the latest version of DockSTARTer")
    MAINOPTS+=("Backup Environment " "Create a backup of your .env file")
    MAINOPTS+=("Prune Docker System " "Remove all unused containers, networks, volumes, images and build cache")

    local MAINCHOICE
    MAINCHOICE=$(whiptail --fb --clear --title "DockSTARTer" --cancel-button "Exit" --menu "What would you like to do?" 0 0 0 "${MAINOPTS[@]}" 3>&1 1>&2 2>&3 || echo "Cancel")

    case "${MAINCHOICE}" in
        "Configuration ")
            run_script 'menu_config' || run_script 'menu_main'
            ;;
        "Install Dependencies ")
            run_script 'ui_install' || run_script 'menu_main'
            ;;
        "Update DockSTARTer ")
            run_script 'update_self' menu || run_script 'menu_main'
            ;;
        "Backup Environment ")
            run_script 'env_backup' menu || run_script 'menu_main'
            ;;
        "Prune Docker System ")
            run_script 'prune_docker' menu || run_script 'menu_main'
            ;;
        "Cancel")
            info "Exiting DockSTARTer."
            return
            ;;
        *)
            error "Invalid Option"
            ;;
    esac
}
