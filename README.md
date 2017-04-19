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
