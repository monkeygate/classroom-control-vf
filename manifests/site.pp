## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  ## Lab 17.1
  $message = hiera('message')
  notify { "The Hiera message is: ${message}": }
  
  ## Lab 13.2
  if $::virtual != 'physical' {
    $vm = capitalize($::virtual)
    notify { "Looks like I'm on: ${vm}": }
  }

  ## Declare the nginx class (Lab 15.7)
  include users::admins

  ## Declare the nginx class (Lab 11.2)
  include nginx
  
  ## Declare the skeleton class (Lab 11.1)
  include memcached
  
  ## Declare the skeleton class (Lab 9.3)
  include skeleton
  
  ## HOMEWORK - Hot entry (Lab 7.3)
  host { 'testing.puppetlabs.vm':
    ensure => present,
    ip     => '127.0.0.1',
  }
  
  ## Lab 7.2 - Execs
  exec { 'cowsay "Welcome to my machine" > /etc/motd':
    path    => '/usr/local/bin',
    creates => '/etc/motd',
  }
  
  ## Notify that came with the repo
  notify { "Hello, my name is ${::hostname}": }
}
