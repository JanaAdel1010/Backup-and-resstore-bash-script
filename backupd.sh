#!/bin/bash
if [ $# -ne 4 ]
then 
	echo "invalid number of parameters"
	echo "please try again"
	exit 1
fi



dir=$1
backupdir=$2
interval=$3
max_backups=$4

if [ ! -d "$dir" ]
then
	echo "directory $dir not found"
	exit 1
fi

if [ ! -d "$backupdir" ]
then
	mkdir -p "$backupdir"
	chmod 755 "$backupdir"
	echo "directory $backupdir has been created"
fi

lastinfo="directory-info.last"
ls -lR  "$dir" > "$lastinfo"

while true
do

sleep "$interval"
newinfo="directory-info.new"
ls -1R "$dir" > "$newinfo"

if ! cmp -s "$lastinfo" "$newinfo"
then
	timestamp=$(date +"%y-%m-%d-%H-%M-%S")
	path="$backupdir/$timestamp"
	mkdir -p "$path"
	chmod 755 "$path"
	cp -r "$dir/." "$path"
	cp "$newinfo" "$lastinfo"
	echo "backup created at $path"

	backup_counter=$(ls -1 "$backupdir" | wc -l)


	if [ "$backup_counter" -gt "$max_backups" ]
		then
			oldbackup=$((backup_counter - max_backups ))
			echo "max backups reached"
			echo "deleting old backups"
			for b in $(ls -1t "$backupdir" | tail -n "$oldbackup")
			do
				rm -rf "$backupdir/$b"
				echo "$b was deleted"
			done
	fi
	else
		echo "no recent change was made"
		rm "$newinfo"

fi

done