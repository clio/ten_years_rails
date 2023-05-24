# frozen_string_literal: true

require "next_rails/gem_info"
require "next_rails/version"
require "next_rails/bundle_report"
require "deprecation_tracker"

module NextRails
  extend self

  def next?
    ENV["BUNDLE_GEMFILE"] == "Gemfile.next"
  end
end
