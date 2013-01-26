begin
  require "puppet/provider/server"
rescue LoadError
  require 'pathname'
  require Pathname.new(__FILE__).dirname + "../../../" + "puppet/provider/server"
end

Puppet::Type.type(:server).provide(:brightbox, :parent => Puppet::Provider::Server) do
  confine :feature => :fog
  def vendor
    'brightbox'
  end
end
