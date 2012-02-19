
class BlockListNode < Treetop::Runtime::SyntaxNode
	def includes
		elements.flat_map do |e|
			e.is_a?(IncludeBlockNode) ? e.include_name : []
		end
	end

	def interfaces
		elements.select do |e|
			e.is_a? InterfaceBlockNode
		end
	end
end

class IncludeBlockNode < Treetop::Runtime::SyntaxNode
	def include_name
		include_block.include_name.file_name.text_value
	end
end

class InterfaceBlockNode < Treetop::Runtime::SyntaxNode
	def name
		iface_block.ident_name.value
	end
	def methods
		iface_block.elements.each do |e|
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

