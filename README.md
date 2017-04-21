# Vagrant Build Template 
```
Prerequisites:
- Vagrant
- Ruby
```

# Usage

## Install dependencies

```
git clone git@github.com:alanrickman/vagrant-template.git
gem install bundler
bundle install
```

## Declare modules

Add module(s) to the Puppetfile e.g.

```
vim ./environments/production/Puppetfile
```

Add module(s) to node definition e.g.

```
vim ./environments/production/manifests/default.pp
```

## Build vagrant box(es)

```
rake build (If you have multiple server please add them to the Rakefile)
```

or

```
vagrant up
```

Note: Only edit servers.yaml

# Running Puppet

Puppet is executed as part of the vagrant provisioning step. If you need to run Puppet after performing an initial `vagrant up` you have two options:

```
vagrant provision # Note this will run all of the vagrant provisioning steps
```

or

```
vagrant ssh
sudo /opt/puppetlabs/bin/puppet apply --hiera_config=/tmp/vagrant-puppet/hiera.yaml --environmentpath /tmp/vagrant-puppet/environments/ --environment production /tmp/vagrant-puppet/environments/production/manifests
```

# Debugging

## Puppet

To see more detailed output from the Puppet run during vagrant provisioning uncomment the line below in the Vagrantfile

```
puppet.options = ['--verbose --debug']
```

## Vagrant

To see INFO level logs run this:

```
VAGRANT_LOG=info vagrant up 2>&1 | tee vagrant.log
```

To see full DEBUG logs run this:

```
VAGRANT_LOG=debug vagrant up 2>&1 | tee vagrant.log
```

# SSH Agent forwarding

To interact with Github you can use SSH agent forwarding which means you can use the SSH key on your local machine instead of having to copy it inside your vagrant VM.

## Add your SSH key

```
ssh-add ~/.ssh/id_rsa
```

to confirm it added successfully run

```
ssh-add -L
```

## Populate SSH config

Add the host that you want to allow to use your local SSH key to your ssh config file e.g.

```
vim ~/.ssh/config


Host 172.17.8.101
  ForwardAgent yes
```

More information about SSH agent forwarding here: https://developer.github.com/guides/using-ssh-agent-forwarding/