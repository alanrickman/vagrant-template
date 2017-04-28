#!/bin/bash

sudo /opt/puppetlabs/bin/puppet apply --hiera_config=/tmp/vagrant-puppet/hiera.yaml --environmentpath /tmp/vagrant-puppet/environments/ --environment production /tmp/vagrant-puppet/environments/production/manifests