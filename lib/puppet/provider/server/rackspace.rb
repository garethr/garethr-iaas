begin
  require "puppet/provider/server"
rescue LoadError
  require 'pathname'
  require Pathname.new(__FILE__).dirname + "../../../" + "puppet/provider/server"
end

Puppet::Type.type(:server).provide(:rackspace, :parent => Puppet::Provider::Server) do
  confine :feature => :fog
  def compute
    Fog::Compute.new(:provider => 'rackspace', :version => 'v2')
  end
end
