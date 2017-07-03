#!/bin/bash
# Author: Sean Cruikshank
# Description: Splunk Enterprise Basic Installer
# TODO: Setup environment variables.
# TODO: Offer options for different linux distributions / installations.

function createusergroup {
  if [[ $(id -u splunk) -eq 0 ]]; then
    if [[ $(sudo useradd splunk) -eq 0 ]]; then
      echo "Splunk user added"
    fi
  else
    exit 1
  fi
}

function tarinstall {
  if [ ! -f /home/splunk/splunk-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz ]; then
		if [[ $(wget -O splunk-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.6.1&product=splunk&filename=splunk-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz&wget=true') -eq 0 ]]; then
			sudo tar xvzf /home/splunk/splunk-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz -C /opt/
      sudo chown -R splunk:splunk /opt/splunk/
		else
			exit 1
		fi
	else
		sudo tar xvzf /home/splunk/splunk-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz -C /opt/
    sudo chown -R splunk:splunk /opt/splunk/
	fi
}

if [[ $(createusergroup) -eq 0 ]]; then
  echo 'User group added succesfully'
else
  echo 'Error occured when creating usergroup...'
  exit 1
fi

if [[ $(tarinstall) -eq 0 ]]; then
  echo 'Splunk installed succesfully'
else
  echo 'Error occured during Splunk install'
  exit 1
fi
