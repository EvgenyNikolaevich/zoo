# When using RSpec, use the metadata `:pact => true` to include all the pact functionality in your spec.

require 'spec_helper'
# require 'pact_helper'
require_relative '../service_providers/pact_helper'
# require_relative '../lib/client'
# require_relative '../lib/event'

describe AnimalServiceClient, pact: true do
  before do
    AnimalServiceClient.base_uri 'localhost:1234'
  end

  subject { AnimalServiceClient.new }

  describe "get_alligator" do
    before do
      animal_service.given("an alligator exists").
        upon_receiving("a request for an alligator").
        with(method: :get, path: '/alligator', query: '').
        will_respond_with(
          status: 200,
          headers: {'Content-Type' => 'application/json'},
          body: {name: 'Betty'} )
    end

    it "returns a alligator" do
      expect(subject.get_alligator).to eq(Alligator.new('Betty'))
    end
  end
end
