require 'fog'

class Puppet::Provider::Server < Puppet::Provider

  def exists?
    _count.times { |i|
      found = _server_exists? _name(i)
      return false unless found
    }
    return true
  end

  def create
    _count.times { |i|
      unless _server_exists?(_name(i))
        server = _compute.servers.create(
          :image_id  => resource[:image],
          :name      => _name(i),
          :flavor_id => resource[:flavor],
        )
        Puppet.debug("Creating new server: #{_name(i)}")
        server.wait_for { ready? }
        Puppet.debug("Server created: #{_name(i)}")
      else
        Puppet.debug("Server already exists: #{_name(i)}")
      end
    }
  end

  def destroy
    _count.times { |i|
      instance = _compute.servers.all.find { |server|
        server.name == _name(i)
      }
      Puppet.debug("Destroying server: #{_name(i)}")
      instance.destroy if _server_exists?(_name(i))
    }
  end

  def _compute
    Fog::Compute.new(:provider => vendor)
  end

  def _server_exists?(name)
    instance = _compute.servers.all.find { |server|
      server.name == name
    }
    found = instance ? true : false
    Puppet.debug("Checking if server #{name} exists: #{found}")
    found
  end

  def _count
    resource[:count] ? resource[:count].to_i : 1
  end

  def _name(suffix)
    "#{resource[:name]}-#{suffix}"
  end

end
