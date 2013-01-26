require 'fog'

class Puppet::Provider::Server < Puppet::Provider

  def compute
    Fog::Compute.new(:provider => vendor)
  end

  def instance
    compute.servers.all.find { |server|
      server.name == resource[:name]
    }
  end

  def exists?
    found = instance ? true : false
    Puppet.debug("Checking if server #{resource[:name]} exists: #{found}")
    found
  end

  def create
    server = compute.servers.create(
      :image_id  => resource[:image],
      :name      => resource[:name],
      :flavor_id => resource[:flavor],
    )
    Puppet.debug("Creating new server: #{resource[:name]}")
    server.wait_for { ready? }
    Puppet.debug("Server created: #{resource[:name]}")
  end

  def destroy
    Puppet.debug("Destroying server: #{resource[:name]}")
    instance.destroy if exists?
  end

end
