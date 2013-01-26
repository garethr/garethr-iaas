require 'spec_helper'

provider_class = Puppet::Type.type(:server).provider(:brightbox)

describe provider_class do

  before do
    @resource = Puppet::Resource.new(:server, "sdsfdssdhdfyjymdgfcjdfjxdrssf")
    @provider = provider_class.new(@resource)
  end

  describe "parse" do
    it "should do something" do
    end
  end

end
