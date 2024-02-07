#!/bin/bash

set -ex

export DEBIAN_FRONTEND=noninteractive

apt-get update -qy
apt-get upgrade -qy

# install SSH
apt-get install -y uuid openssh-server git git-lfs

# configure sshd
sed -i 's/#MaxAuthTries [0-9]\+/MaxAuthTries 32/g' /etc/ssh/sshd_config
mkdir -p /run/sshd

rm /etc/ssh/ssh_host_* || :
cp /setup/etc/ssh/* /etc/ssh/

# remove systemd
apt-get purge -qy systemd
apt-get autoremove -qy

# add test user
UID_TESTER=1000
useradd -m --uid ${UID_TESTER} tester
mkdir /home/tester/.ssh
chown tester:tester /home/tester/.ssh
chmod 600 /home/tester/.ssh
USER=tester /bin/bash /home/tester/configure-git.sh

# global screen configuration
sed -i 's|#startup_message off|startup_message off|g' /etc/screenrc
echo 'shell /bin/bash' >> /etc/screenrc

mkdir /work
chown tester:tester /work
chmod 755 /work

# cleanup
source /setup/cleanup-image.sh
