begin
  require "action_view"
rescue LoadError
  puts "ActionView not available"
end

module TenYearsRails
  class GemInfo
    if defined?(ActionView)
      include ActionView::Helpers::DateHelper
    end

    class NullGemInfo < GemInfo
      def initialize; end

      def age
        "-"
      end

      def created_at
        Time.now
      end

      def up_to_date?
        false
      end

      def version
        "NOT FOUND"
      end

      def unsatisfied_rails_dependencies(*)
        ["unknown"]
      end

      def state(_)
        :null
      end
    end

    def self.all
      Gem::Specification.each.map do |gem_specification|
        new(gem_specification)
      end
    end

    attr_reader :gem_specification, :version, :name
    def initialize(gem_specification)
      @gem_specification = gem_specification
      @version = gem_specification.version
      @name = gem_specification.name
    end

    def age
      if respond_to?(:time_ago_in_words)
        "#{time_ago_in_words(created_at)} ago"
      else
        created_at.strftime("%b %e, %Y")
      end
    end

    def sourced_from_git?
      !!gem_specification.git_version
    end

    def created_at
      @created_at ||= gem_specification.date
    end

    def up_to_date?
      version == latest_version.version
    end

    def state(rails_version)
      if compatible_with_rails?(rails_version: rails_version)
        :compatible
      elsif latest_version.compatible_with_rails?(rails_version: rails_version)
        :latest_compatible
      elsif latest_version.version == "NOT FOUND"
        :no_new_version
      else
        :incompatible
      end
    end

    def latest_version
      @latest_version ||= begin
        latest_gem_specification = Gem.latest_spec_for(name)
        if latest_gem_specification
          GemInfo.new(latest_gem_specification)
        else
          NullGemInfo.new
        end
      end
    end

    def compatible_with_rails?(rails_version: Gem::Version.new("5.0"))
      unsatisfied_rails_dependencies(rails_version: rails_version).empty?
    end

    def unsatisfied_rails_dependencies(rails_version:)
      rails_dependencies = gem_specification.runtime_dependencies.select {|dependency| rails_gems.include?(dependency.name) }

      rails_dependencies.reject do |rails_dependency|
        rails_dependency.requirement.satisfied_by?(Gem::Version.new(rails_version))
      end
    end

    def from_rails?
      rails_gems.include?(name)
    end

    private def rails_gems
      [
        "rails",
        "activemodel",
        "activerecord",
        "actionmailer",
        "actioncable",
        "actionpack",
        "actionview",
        "activejob",
        "activestorage",
        "activesupport",
        "railties",
      ]
    end
  end
end
