require "spec_helper"
require "timecop"

RSpec.describe NextRails::GemInfo do
  let(:release_date) { Time.utc(2019, 7, 6, 0, 0, 0) }
  let(:now) { Time.utc(2019, 7, 6, 12, 0, 0) }
  let(:spec) do
    Gem::Specification.new do |s|
      s.date = release_date
    end
  end

  subject { NextRails::GemInfo.new(spec) }

  describe "#age" do
    around do |example|
      Timecop.travel(now) do
        example.run
      end
    end

    context "when ActionView is available" do
      it "returns a time ago" do
        expect(subject.age).to eq("about 12 hours ago")
      end
    end

    context "when ActionView is not available" do
      let(:result) { now.strftime("%b %e, %Y") }

      before do
        subject.instance_eval('undef :time_ago_in_words')
      end

      it "returns a date" do
        expect(subject.age).to eq(result)
      end
    end
  end
end
