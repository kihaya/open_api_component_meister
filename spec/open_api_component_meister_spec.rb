require "spec_helper"

class User < ActiveRecord::Base
end

RSpec.describe OpenApiComponentMeister do
  let!(:user) { User.create(name: "Test Taro", age: 20) }
  after { User.destroy_all }

  context do
    it do
      expect(true).to eq true
    end
  end
end
