Puppet::Type.type(:load_balancer).provide(:rackspace) do

  confine :feature => :fog

  def client
    Fog::Rackspace::LoadBalancers.new
  end

  def instance
    client.load_balancers.all.find { |lb|
      lb.name == resource[:name]
    }
  end

  def exists?
    found = instance ? true : false
    Puppet.debug("Checking if load balancer #{resource[:name]} exists: #{found}")
    found
  end

  def create
    compute = Fog::Compute.new(:provider => 'rackspace', :version => 'v2')
    lb = client.load_balancers.create(
       :name => resource[:name],
       :protocol => 'HTTP',
       :port => 80,
       :virtual_ips => [{ :type => 'PUBLIC'}],
       :nodes => [{:address => compute.servers.first.addresses['public'].first['addr'], :port => 80, :condition => 'ENABLED'}],
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
