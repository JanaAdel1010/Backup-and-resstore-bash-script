#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Invalid number of parameters."
    echo "Please try again."
    exit 1
fi

dir=$1          
backupdir=$2   


if [ ! -d "$dir" ]; then
    echo "Source directory $dir not found."
    exit 1
fi


if [ ! -d "$backupdir" ]; then
    echo "Destination directory $backupdir not found."
    exit 1
fi


Backups=($(ls -1t "$backupdir"))


if [ ${#Backups[@]} -eq 0 ]; then
    echo "No backups found in $backupdir."
    exit 1
fi


current_index=0


while true; do
    
    current_backup=${Backups[$current_index]}
    echo "Current backup is $current_backup"

    
    echo "Select an option:"
    echo "1 - Restore to the previous version"
    echo "2 - Restore to the next version"
    echo "3 - Terminate"

    
    read -p "Selection: " selection
    case "$selection" in
        1)  
            if [ $current_index -eq $((${#Backups[@]} - 1)) ]; then
                echo "No previous version available."
            else
                current_index=$((current_index - 1))  
                prev_backup=${Backups[$current_index]}
                rm -rf "$dir"/*  
                cp -r "$backupdir/$prev_backup/." "$dir"  
                echo "Restored to previous version: $prev_backup"
            fi
            ;;
        2)  
            if [ $current_index -eq 0 ]; then
                echo "No next version available."
            else
                current_index=$((current_index + 1)) 
                next_backup=${Backups[$current_index]}
                rm -rf "$dir"/*  
                cp -r "$backupdir/$next_backup/." "$dir"  
                echo "Restored to next version: $next_backup"
            fi
            ;;
        3)  
            echo "This restore session is terminating."
            break
            ;;
        *) 
            echo "Invalid selection. Please try again."
            ;;
    esac
done