require "spec_helper"

class User < ActiveRecord::Base
end

RSpec.describe OpenApiComponentMeister do
  describe OpenApiComponentMeister::Load do
    let!(:user) { User.create(name: "Test Taro", age: 20) }
    after { User.destroy_all }

    let(:target) { described_class.new(user) }

    describe "load_schema!" do
      subject do
        target.load_schema!
        target.schema_hash
      end

      context do
        it "get column types" do
          expect(subject["id"].name).to eq "id"
          expect(subject["id"].type).to eq :integer

          expect(subject["name"].name).to eq "name"
          expect(subject["name"].type).to eq :string

          expect(subject["age"].name).to eq "age"
          expect(subject["age"].type).to eq :integer
        end
      end
    end
  end
end
