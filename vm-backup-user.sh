#! /bin/bash
echo 'Running Backup'
cd ~/server
tar -zcvf world-backup.tar.gz world
gsutil cp world-backup.tar.gz gs://my-minecraft-backup