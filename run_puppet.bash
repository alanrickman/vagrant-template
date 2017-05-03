#!/bin/bash

# Install modules from Puppetfile
cd /tmp/vagrant-puppet/environments/production && sudo r10k puppetfile install --verbose

# Copy local dev modules
sudo cp -R /home/vagrant/$(hostname)/local/modules/* /tmp/vagrant-puppet/environments/production/modules/

# Run Puppet
sudo /opt/puppetlabs/bin/puppet apply --hiera_config=/tmp/vagrant-puppet/hiera.yaml --environmentpath /tmp/vagrant-puppet/environments/ --environment production /tmp/vagrant-puppet/environments/production/manifests
