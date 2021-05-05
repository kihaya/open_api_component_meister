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
    let(:user) { User.create(name: "Test Taro", age: 20) }
    let(:load) { OpenApiComponentMeister::Load.new(user) }

    before { load.load_schema! }

    let!(:target) { described_class.new(load: load) }

    context do

      let(:expected) do
        { "User" => {
            "properties" => [
              { "id" => { "type" => "integer" } },
              { "name" => { "type" => "string" } },
              { "age" => { "type" => "integer" } }
            ],
            "type" => "object"
          }
        }
      end

      it do
        expect(target.data).to eq expected
      end
    end
  end

  describe OpenApiComponentMeister::TypeMapper do
    subject { described_class.new(type: t).oas_type }

    context "integer" do
      let!(:t) { :integer }
      it { is_expected.to eq :integer }
    end

    context "float" do
      let!(:t) { :float }
      it { is_expected.to eq :number }
    end

    context "string" do
      let!(:t) { :string }
      it { is_expected.to eq :string }
    end

    context "text" do
      let!(:t) { :text }
      it { is_expected.to eq :string }
    end

    context "primary_key" do
      let!(:t) { :primary_key }
      it { is_expected.to eq :integer }
    end

    context "boolean" do
      let!(:t) { :boolean }
      it { is_expected.to eq :boolean }
    end

    context "no support" do
      let!(:t) { :hoge }
      it do
        expect do
          subject
        end.to raise_error(OpenApiComponentMeister::NotSupportedTypeError)
      end
    end
  end

  describe OpenApiComponentMeister::Output do
    context do
      let(:user) { User.create(name: "Test Taro", age: 20) }
      let(:load) { OpenApiComponentMeister::Load.new(user) }

      before { load.load_schema! }

      let!(:transform) { OpenApiComponentMeister::Transform.new(load: load) }

      let(:expected) do
        <<~EOS
            ---
            User:
              type: object
              properties:
              - id:
                  type: integer
              - name:
                  type: string
              - age:
                  type: integer
        EOS
      end

      it do
        expect { OpenApiComponentMeister::Output.new(transform: transform).run! }.to output(expected).to_stdout
      end
    end
  end
end
