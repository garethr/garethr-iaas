Puppet::Type.newtype(:server) do
  @doc = 'type representing a virtual machine instance'

  ensurable

  newparam(:name, :namevar => true) do
    desc 'the name of the instance'
  end

  newparam(:image) do
    desc 'the image id to use for the new instance'
    validate do |value|
      raise Puppet::Error, "Image id should not contains spaces" if value =~ /\s/
      raise Puppet::Error, "Empty values are not allowed" if value == ""
    end
  end

  newparam(:flavor) do
    desc 'the flavor id of the new instance'
    validate do |value|
      raise Puppet::Error, "Flavor id should not contains spaces" if value =~ /\s/
      raise Puppet::Error, "Empty values are not allowed" if value == ""
    end
  end

  newparam(:count) do
    desc 'the number of instances of this type'
    validate do |value|
      raise Puppet::Error, "Count should be a number" unless value =~ /\d+/
      raise Puppet::Error, "Empty values are not allowed" if value == ""
    end
  end

  newparam(:user_data) do
    desc 'local filepath for userdata'
  end

end
