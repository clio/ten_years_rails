require_relative ".././spec_helper"
require_relative "../../lib/next_rails/bundle_report"

RSpec.describe NextRails::BundleReport do
  describe "#compatible_ruby_version" do
    context "when rails_version is a valid one" do
      it "returns the correct ruby version" do
        rails_version = { rails_version: "7.0.0" }
        ruby_version = NextRails::BundleReport.compatible_ruby_version(rails_version)
        expect(ruby_version).to eq("2.7.0")
      end
    end
    
    context "when rails_version is an invalid one" do
      it "returns nil for ruby version" do
        rails_version = { rails_version: "0.0.0" }
        ruby_version = NextRails::BundleReport.compatible_ruby_version(rails_version)
        expect(ruby_version).to eq(nil)
      end
    end
  end
end
