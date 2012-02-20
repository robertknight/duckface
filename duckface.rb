#!/usr/bin/ruby

$: << File.dirname(__FILE__)

require 'rubygems'
require 'mustache'
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

header = result.header_text.strip

interfaces = []
result.interfaces.each do |iface|
	interface = {}
	interface[:name] = iface.name

	methods = []
	iface.methods.each do |method|
		method_map = {}
		method_map[:name] = method.name
		method_map["return-type"] = method.return_type

		param_list = ""
		arg_list = ""

		method.params.each_with_index do |e,i|
			if !param_list.empty?
				param_list += ", "
			end
			if !arg_list.empty?
				arg_list += ", "
			end
			param_list += "#{e.type} #{e.name}"
			arg_list += "#{e.name}"
		end

		method_map["param-list"] = param_list
		method_map["arg-list"] = arg_list
		method_map["has-params"] = !param_list.empty?
		method_map["has-return-value"] = method.return_type != "void"
		method_map["iface-name"] = iface.name
		methods << method_map
	end

	interface[:methods] = methods
	interfaces << interface
end

class TemplateRenderer < Mustache
	# disable HTML escaping to avoid the need to use triple-mustache
	# tags for type names (which may contain '&' and in future possibly
	# templates as well)
	def escapeHTML(str)
		str
	end
end

class_template_vars = {
	"input-file" => File.basename(file),
	:header => header,
	:interfaces => interfaces
}

template_path = File.dirname(__FILE__) + "/class.mustache"
template = TemplateRenderer.new
output = template.render(File.read(template_path), class_template_vars)

output_file = File.dirname(file) + '/' + File.basename(file,".if.h") + ".h"

File.open(output_file,'w') do |file|
	file.write output
end

