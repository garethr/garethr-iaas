Puppet::Type.newtype(:load_balancer) do
  @doc = 'type representing a virtual load balancer'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'the name of the load balancer'
  end

  newparam(:healthcheck) do
  end

  newparam(:listeners) do
  end

  newparam(:nodes) do
  end

end
