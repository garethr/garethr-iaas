require 'puppet/util/feature'

Puppet.features.rubygems?
Puppet.features.add(:fog, :libs => "fog")
