#!/bin/bash

# Validate input parameters
if [[ !("$#" -eq 2) ]]; 
    then echo "Parameters missing for puppet enterprise configuration." >&2
    exit 1
fi

# Get parameters
pe_version=$1
console_pw=$2

# Configure for Puppet Enterprise version
pe_url=https://pm.puppetlabs.com/puppet-enterprise/2017.1.0/puppet-enterprise-2017.1.0-ubuntu-16.04-amd64.tar.gz


# Set up variables
pe_tar=${pe_url##*/}
pe_folder=${pe_tar%%.tar.gz}

# Get installation package
cd /tmp; wget -q ${pe_url}

# Unpack installation package
tar -xf ${pe_tar}
cd ${pe_folder}

# Create configuration file
sed '/console_admin_password/c \
   "console_admin_password":"'$console_pw'"' conf.d/pe.conf > conf.d/azure-pe.conf

# Start the installation
sudo ./puppet-enterprise-installer -c conf.d/azure-pe.conf

exit 0