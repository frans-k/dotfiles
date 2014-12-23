require 'rubygems'

rails = File.join Dir.getwd, 'config', 'environment.rb'
if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
  #extend Rails::ConsoleMethods
  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0] == "3" || Rails.version[0..0] == "4"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
  end
end

if defined?(Rails) && Rails.env
  extend Rails::ConsoleMethods
end

require 'awesome_print'


# vim FTW
Pry.config.editor = "subl"

# My pry is polite
Pry.hooks = { :after_session => proc { puts "bye-bye" } }

# Prompt with ruby version
Pry.prompt = [proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

# %w{map_by_method hirb}.each { |gem| require gem }

# Toys methods
# Stealed from https://gist.github.com/807492
class Array
  def self.toy(n=10, &block)
    block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
  end
end

# loading rails configuration if it is running as a rails console
#load File.dirname(__FILE__) + '/.railsrc' if defined?(Rails) && Rails.env
