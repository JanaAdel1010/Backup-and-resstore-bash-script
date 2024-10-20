The project backups data from a source directory to a destinantion directory
and also restores various versions of source directory from destinantion directory back to the source directory
**backupd**.sh is backup script with the bash code that regulalry checks the source directory for any change if any change is found a backup copy is taken from source to directory 
**restore.sh** is restore script with the bash code that promts a selection menu to the user to display directory of current backup and asks user to select next or previous backup to restore back to the source directory or to terminate the session
**makefile** is the file used to run both restore and backup scripts while checking for the exisistance of such directory
**read.me** instruction file on how to run and test the project 

**prerequisties**
bash -----> the default shell for linux systems including ubuntu
make -----> to run the makefile we need to make sure make is installed

if bash is installed check version using : bash --version
if not install using: sudo abt install bash or to update package list : sudo abt update

if make is not installed: sudo apt install make
**To use project**
we need to specify the source and destinantion directories in the makefile 
aslo the interval and the max number of backups
after that simply run each script using : make backup for the backup and : make restore for the restore 
run : make clean to delete backup directory if you wish