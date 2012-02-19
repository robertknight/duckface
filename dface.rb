#!/usr/bin/ruby

$: << File.dirname(__FILE__)

require 'treetop'
require 'grammar.rb'
require 'optparse.rb'

OptionParser.new do |parser|
	parser.banner = "Usage: #{$0} <interface file>"
end.parse!

if ARGV.empty?
	$stderr.puts "No input interface file specified"
	exit 1
end

file = ARGV[0]

parser = DuckfaceParser.new
result = parser.parse(File.read(file))

if !result
	puts "Failed to parse #{file}"

	puts parser.failure_reason
	puts parser.failure_line
	puts parser.failure_column
	
	exit 1
end

result.includes.each do |incl|
	puts "Included file: #{incl}"
end

result.interfaces.each do |iface|
	puts "Interface: #{iface.name}"
	puts "Method count: #{iface.methods.length}"

	iface.methods.each do |method|
		puts "\tmethod #{method.name} returns #{method.return_type} param count #{method.params.length}"
		method.params.each_with_index do |e,i|
			puts "\t\tparam #{i} type: #{e.type} name: #{e.name}"
		end
	end
end
