An experiment using Puppet to define and control instances from common
Infrastructure as a Service providers.

Puppet is a number of different things, if you ignore the common types
and the abstractions for different operating systems you have a domain
specific language for defining and managing state based on a dependency
graph. This project abuses that to control virtual machines.

## Usage

First you can define a virtual machine like so:

    server { 'test-instance-1':
      ensure   => present,
      provider => brightbox,
      image    => 'img-q6gc8', # ubuntu 12.04
    }

Note the provider bit. Currently I've written basic providers for
Brightbox and Rackspace, with AWS on the way.

    puppet apply tests/manifest.pp --modulepath ../ --debug --summarize

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

I also have in mind to allow a single resource to manage multiple
individual instances, so something like this:

    server { 'web-server':
      ensure   => present,
      count    => 5
      provider => brightbox,
      image    => 'img-q6gc8', # ubuntu 12.04
    }

Passing userdata or allowing for some sort of bootstrap script to be run
would be next on the agenda. Then maybe more types and providers.


