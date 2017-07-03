#!/bin/bash
# Author: Sean Cruikshank
# Description: Simple Splunk Universal Forwarder Installation

function createusergroup {
  if [[ $(id -u splunk) -eq 0 ]]; then
    if [[ $(sudo useradd splunk) -eq 0 ]]; then
      echo "Splunk user added"
    fi
  else
    exit 1
  fi
}

function forinstall {
  if [ ! -f /home/splunk/splunkforwarder-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz ]; then
    if [[ $(wget -O splunkforwarder-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.6.1&product=universalforwarder&filename=splunkforwarder-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz&wget=true') -eq 0 ]]; then
			sudo tar xvzf splunkforwarder-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz -C /opt/
      sudo chown -R splunk:splunk /opt/splunkforwarder/
		else
			exit 1
		fi
	else
		sudo tar xvzf splunkforwarder-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz -C /opt/
    sudo chown -R splunk:splunk /opt/splunkforwarder/
	fi
}

if [[ $(createusergroup) -eq 0 ]]; then
  echo 'User group added succesfully'
else
  echo 'Error occured when creating usergroup...'
  exit 1
fi

if [[ $(forinstall) -eq 0 ]]; then
  echo 'Forwarder installed succesfully'
else
  echo 'Error occured during forwarder install'
  exit 1
fi
