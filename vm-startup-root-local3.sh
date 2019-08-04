#! /bin/bash
echo 'Startup Script v0.3'

USER_NAME=minecraft
TOOLS_PATH=/opt/minecraft-gcp
SERVER_PATH=/opt/minecraft-server
WORLD_PATH=${SERVER_PATH}/world

echo 'Updating system..'
apt-get --yes update
apt-get --yes upgrade
echo 'Installing tools'
apt-get --yes install git screen java

cat /etc/passwd | grep ${USER_NAME} >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "Minecraft User Exists - Running Backup"
    # Run a backup.
    cd ${TOOLS_PATH}
    git pull
    su - ${USER_NAME} -c 'bash /opt/minecraft-gcp/vm-backup-user.sh'
else
    # Init the server if it doesn't have a user currently.
    echo "Minecraft User Not Found - Init New Server"
    useradd ${USER_NAME}
    mkdir ${TOOLS_PATH}
    git clone https://www.github.com/GreenishBlue/minecraft-gcp ${TOOLS_PATH}
    su - ${USER_NAME} -c 'bash /opt/minecraft-gcp/vm-init-user.sh'
fi

# Execute the default startup script.
su - ${USER_NAME} -c 'bash /opt/minecraft-gcp/vm-startup-user.sh'