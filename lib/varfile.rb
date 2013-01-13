require "varfile/version"
require 'thor'
require 'pathname'

module Varfile
  class Command < Thor
    attr_reader :file_path
    attr_accessor :output

    desc "set", "sets a key to file"
    method_options :file => :string
    def set(key, value)
      file = file_or_default(options)

      key = normalize_key(key)
      value = normalize_value(value)
     
      content = read_file(file)
      content[key] = value
      save_file(content, file)
    end

    desc "get", "get the value of key from file"
    method_options :file => :string
    def get(key)
      file = file_or_default(options)
      content = read_file(file)
      puts_and_return content[key]
    end

    desc "list", "lists all keys to file" 
    method_options :file => :string
    def list
      file = file_or_default(options)
      content = read_file(file)
      puts_and_return printable_content(content)
    end

    def output
      @output ||= STDOUT
    end

    private 

    def puts_and_return(text)
      output.puts text
      text
    end

    def file_or_default(options)
      file = options[:file] ? options[:file] : default_file
      @file_path = Pathname.new(file)
    end

    def save_file(content, file)
      file = File.open(file, 'w') 
      file.write printable_content(content)
      file.close
    end

    def printable_content(content)
      string = ""
      content.each do |key, value| 
        string << "#{key}=#{value}\n"
      end
      string 
    end
        
    def read_file(file)
      content = {}
      if file.exist? 
        File.new(file, 'r').readlines.each do |line|
          next if line.strip == '' 

          key, value = line.split '='
          content[key] = value.strip
        end
      end
      content
    end

    def default_file
      Pathname.new('Varfile')
    end
    
    def normalize_key(key)
      key.strip.gsub('=', '').gsub("\n", '')
    end

    def normalize_value(value)
      value.strip.gsub('=', '').gsub("\n", '')
    end
      
  end
end
