#! /bin/bash
echo 'Startup Script v0.2'
USER_NAME=minecraft
cat /etc/passwd | grep ${USER_NAME} >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "User Exists - Running Backup"
    # Run a backup.
    su - ${USER_NAME} -c 'wget -O - https://raw.githubusercontent.com/GreenishBlue/minecraft-gcp/master/vm-backup-user.sh | bash'
else
    # Init the server if it doesn't have a user currently.
    echo "User Not Found - Init"
    useradd ${USER_NAME}
    su - ${USER_NAME} -c 'wget -O - https://raw.githubusercontent.com/GreenishBlue/minecraft-gcp/master/vm-init-user.sh | bash'
fi

# Execute the default startup script.
su - ${USER_NAME} -c 'wget -O - https://raw.githubusercontent.com/GreenishBlue/minecraft-gcp/master/vm-startup-user.sh | bash'