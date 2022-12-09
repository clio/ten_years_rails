require_relative ".././spec_helper"
require_relative "../../lib/next_rails/gem_info"

RSpec.describe NextRails::GemInfo do
  describe "#state" do
    let(:mock_gem) { Struct.new(:name, :version, :runtime_dependencies) }
    let(:mocked_dependency) { Struct.new(:name, :requirement) }
    it "returns :incompatible if gem specifies a rails dependency but no compatible version is found" do

      mocked_dependency_requirement = double("requirement")
      allow(mocked_dependency_requirement).to receive(:satisfied_by?).and_return(false)
      runtime_deps = [mocked_dependency.new("rails", mocked_dependency_requirement)]
      incompatible_gem = mock_gem.new('incompatible', '0.0.1', runtime_deps)
      rails_version = "7.0.0"
      gem_info = NextRails::GemInfo.new(incompatible_gem)

      expect(gem_info.state(rails_version)).to eq(:incompatible)
    end

  end

  describe "#find_latest_compatible" do
    let(:mock_gem) { Struct.new(:name, :version) }
    it "sets latest_compatible_version to NullGem if no specs are found" do
      fetcher_double = double("spec_fetcher")
      allow(fetcher_double).to receive(:available_specs).and_return([[],[]])
      allow(Gem::SpecFetcher).to receive(:new).and_return(fetcher_double)
      gem = mock_gem.new('gem_name', "0.0.1")

      gem_info = NextRails::GemInfo.new(gem)
      gem_info.find_latest_compatible
      expect(gem_info.latest_compatible_version).to be_a(NextRails::GemInfo::NullGemInfo)
    end

  end
end