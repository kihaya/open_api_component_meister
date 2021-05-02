require "spec_helper"

class User < ActiveRecord::Base
end

RSpec.describe OpenApiComponentMeister do
  after { User.destroy_all }

  describe OpenApiComponentMeister::Load do
    let!(:user) { User.create(name: "Test Taro", age: 20) }
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

    describe "model_name" do
      context do
        it "valid name" do
          expect(target.model_name).to eq "User"
        end
      end
    end
  end

  describe OpenApiComponentMeister::Transform do
    let(:schema_hash) do
      user = User.create(name: "Test Taro", age: 20)
      OpenApiComponentMeister::Load.new(user).load_schema!
    end

    let(:target) { described_class.new(model_name: "User", schema_hash: schema_hash) }

    subject { target }

    context do

      let(:expected) do
        { "User" => {
            :properties => [
              { "id" => { :type => :integer } },
              { "name" => { :type => :string } },
              { "age" => { :type => :integer } }
            ],
            :type => "object"
          }
        }
      end

      it do
        expect(target.data).to eq expected
      end
    end
  end
end
