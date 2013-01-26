Puppet::Type.type(:load_balancer).provide(:brightbox) do

  confine :feature => :fog

  def compute
    Fog::Compute.new(:provider => 'brightbox')
  end

  def instance
    compute.load_balancers.all.find { |lb|
      lb.name == resource[:name]
    }
  end

  def exists?
    found = instance ? true : false
    Puppet.debug("Checking if load balancer #{resource[:name]} exists: #{found}")
    found
  end

  def create
    lb = compute.load_balancers.create(
       :listeners => [{"protocol"=>"http", "in"=>80, "out"=>80, "timeout"=>50000}],
       :healthcheck => {"type"=>"http", "request"=>"/", "port"=>80, "interval"=>5000, "timeout"=>5000, "threshold_up"=>3, "threshold_down"=>3},
       :nodes => [{ :node => compute.servers.first.id }],
       :name => resource[:name],
    )
    Puppet.debug("Creating new load balancer: #{resource[:name]}")
    lb.wait_for { ready? }
    Puppet.debug("Load balancer created: #{resource[:name]}")
  end

  def destroy
    Puppet.debug("Destroying load balancer: #{resource[:name]}")
    instance.destroy if exists?
  end

end
