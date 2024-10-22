require "rainbow"

class NextRails::BundleReport::RubyVersionCompatibility
  MINIMAL_VERSION = 1.0
  attr_reader :gems, :options

  def initialize(gems: NextRails::GemInfo.all, options: {})
    @gems = gems
    @options = options
  end

  def generate
    return invalid_message unless valid?

    message
  end

  private

  def message
    output = Rainbow("=> Incompatible gems with Ruby #{ruby_version}:").white.bold
    incompatible.each do |gem|
      output += Rainbow("\n#{gem.name} - required Ruby version: #{gem.gem_specification.required_ruby_version}").magenta
    end
    output += Rainbow("\n\n#{incompatible.length} incompatible #{incompatible.one? ? 'gem' : 'gems' } with Ruby #{ruby_version}").red
    output
  end

  def incompatible
    gems.reject { |gem| gem.compatible_with_ruby?(ruby_version) }
  end

  def ruby_version
    options[:ruby_version].to_f
  end

  def invalid_message
    Rainbow("=> Invalid Ruby version: #{options[:ruby_version]}.").red.bold
  end

  def valid?
    ruby_version > MINIMAL_VERSION
  end
end
