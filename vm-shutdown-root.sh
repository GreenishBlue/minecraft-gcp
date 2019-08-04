#! /bin/bash
USER_NAME=minecraft
su - ${USER_NAME} -c 'wget -O - https://raw.githubusercontent.com/GreenishBlue/minecraft-gcp/master/vm-shutdown-user.sh | bash'