#!/usr/bin/env sh
set -ex

# Define variables
DEFAULT_VENV_PATH="/opt/venv/ansible"
if [ -z "${VENV_PATH}" ]; then
	VENV_PATH=${DEFAULT_VENV_PATH}
fi

# INSTALL APT-PACKAGES
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
apt-get update
apt-get -qqy install --no-install-recommends apt-utils > /dev/null 2>&1
apt-get -qqy install --no-install-recommends python3-simplejson python3-pip python3-venv
apt-get autoclean

# INSTALL PIP PACKAGES
python3 -m venv ${VENV_PATH}
. ${VENV_PATH}/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade paramiko ansible-core

# INSTALL ANSIBLE-GALAXY COLLECTION(S)
ansible-galaxy collection install community.general

