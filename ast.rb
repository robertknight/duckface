
class BlockListNode < Treetop::Runtime::SyntaxNode
	def header_text
		header_block.content
	end

	def interfaces
		ifaces.elements.select do |e|
			e.is_a? InterfaceBlockNode
		end
	end
end

class HeaderBlockNode < Treetop::Runtime::SyntaxNode
	def content
		text_value
	end
end

class InterfaceBlockNode < Treetop::Runtime::SyntaxNode
	def name
		ident_name.value
	end
	def methods
		elements.each do |e|
			if e.is_a? MethodListNode
				return e.methods
			end
		end
	end
end

class IdentifierNode < Treetop::Runtime::SyntaxNode
	def value
		text_value.strip
	end
end

class MethodListNode < Treetop::Runtime::SyntaxNode
	def methods
		elements.select do |e|
			e.is_a? MethodDeclNode
		end
	end
end

class MethodDeclNode < Treetop::Runtime::SyntaxNode
	def name
		ident_name.value
	end

	def return_type
		type_name.text_value.strip
	end

	def params
		elements.each do |e|
			if e.is_a?(ParamListNode)
				return e.params
			elsif e.is_a?(ParamDeclNode)
				return [e]
			end
		end
		return []
	end

	def qualifiers
		qualifier_list.value
	end
end

class ParamListNode < Treetop::Runtime::SyntaxNode
	def params
		elements.flat_map do |e|
			if e.is_a?(ParamDeclNode)
				e
			elsif e.is_a?(ParamListNode)
				e.params
			else
				[]
			end
		end
	end
end

class ParamDeclNode < Treetop::Runtime::SyntaxNode
	def type
		type_name.text_value.strip
	end
	
	def name
		if param_name.is_a?(IdentifierNode)
			param_name.value
		else
			nil
		end
	end
end

class CvQualifierNode < Treetop::Runtime::SyntaxNode
	def value
		text_value.strip
	end
end

