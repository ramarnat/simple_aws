require 'test_helper'
require 'aws/elb'

describe AWS::ELB do

  before do
    @api = AWS::ELB.new "key", "secret"
  end

  it "points to the endpoint" do
    @api.uri.must_equal "https://elasticloadbalancing.amazonaws.com"
  end

  it "works with the current version" do
    @api.version.must_equal "2011-11-15"
  end

  describe "API calls" do

    it "builds and signs calls with ActionParam rules" do
      AWS::Connection.any_instance.expects(:call).with do |request|
        params = request.params
        params.wont_be_nil

        params["Action"].must_equal "DescribeLoadBalancers"
        params["Signature"].wont_be_nil

        true
      end

      obj = AWS::ELB.new "key", "secret"
      obj.describe_load_balancers
    end

  end
end
