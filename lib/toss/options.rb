require 'optparse'

module Toss
  module Options

    def self.load
      options = { :recipes => [], :pre_set => {}, :set => {}, :verbose => false }

      optparse = OptionParser.new do |opts|
        opts.on('-e', '--environment ENVIRONMENT', 'Environment to deploy as') do |environment|
          options[:environment] = environment
        end

        opts.on('-f', '--file FILE', 'A recipe file to run. Option may be used more than once.') do |file|
           options[:recipes] << value 
        end

        opts.on("-S", "--set-before NAME=VALUE", "Set a variable before the recipes are loaded.") do |name_value|
          name, value = name_value.split("=", 2)
          options[:pre_set][name.to_sym] = value
        end

        opts.on("-s", "--set NAME=VALUE", "Set a variable after the recipes are loaded.") do |name_value|
          name, value = name_value.split("=", 2)
          options[:set][name.to_sym] = value
        end

        opts.on('-v', '--verbose', 'Show more information about the process') do
          options[:verbose] = true
        end

        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit
        end
      end

      begin
        optparse.parse!
      rescue OptionParser::InvalidOption, OptionParser::MissingArgument
        puts $!.to_s
        puts optparse
        exit
      end

      options
    end

  end
end