An experiment using Puppet to define and control instances from common
Infrastructure as a Service providers.

Puppet is a number of different things, if you ignore the common types
and the abstractions for different operating systems you have a domain
specific language for defining and managing state based on a dependency
graph. This project abuses that to control virtual machines.

## Usage

First you can define a virtual machine like so:

    server { 'test-instance':
      ensure   => present,
      provider => brightbox,
      image    => 'img-q6gc8', # ubuntu 12.04
    }

Note the provider bit. Currently I've written basic providers for
Brightbox and Rackspace, with AWS on the way.

    puppet apply tests/manifest.pp --modulepath ../ --debug --summarize

By default this brings up one instance but if you want several you can
pass a count like so. This scales up nicely (ie. change the number from
2 to 3) but not yet down. Ensure absent works as expected and deletes
all specified instances.

    server { 'web-server':
      ensure   => present,
      count    => 5
      provider => brightbox,
      image    => 'img-q6gc8', # ubuntu 12.04
    }

If you want to give it a spin you'll need to have the
[fog](http://fog.io/) gem installed and have a fog configuration file in your home directory something like:

    :default:
      :brightbox_client_id: ''
      :brightbox_secret: ''
      :rackspace_username: ''
      :rackspace_api_key: ''
      :aws_access_key_id: ''
      :aws_secret_access_key: '' 

## Next Steps

This is currently a proof of concept, but one I think worth playing
around with. I've already started hacking on adding a load balancer type and have hard coded providers in the source code for anyone interested.

Passing userdata or allowing for some sort of bootstrap script to be run
would be next on the agenda. Then maybe more types and providers.


