# Autogenerated from a Treetop grammar. Edits may be lost.


require 'ast.rb'

module Duckface
  include Treetop::Runtime

  def root
    @root ||= :block_list
  end

  module BlockList0
    def header_block
      elements[0]
    end

    def ifaces
      elements[1]
    end

    def s
      elements[2]
    end
  end

  def _nt_block_list
    start_index = index
    if node_cache[:block_list].has_key?(index)
      cached = node_cache[:block_list][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_header_block
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        r3 = _nt_iface_block
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        r4 = _nt_s
        s0 << r4
      end
    end
    if s0.last
      r0 = instantiate_node(BlockListNode,input, i0...index, s0)
      r0.extend(BlockList0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:block_list][start_index] = r0

    r0
  end

  module HeaderBlock0
  end

  def _nt_header_block
    start_index = index
    if node_cache[:header_block].has_key?(index)
      cached = node_cache[:header_block][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      i2 = index
      if has_terminal?("interface", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 9))
        @index += 9
      else
        terminal_parse_failure("interface")
        r3 = nil
      end
      if r3
        r2 = nil
      else
        @index = i2
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s1 << r2
      if r2
        if index < input_length
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("any character")
          r4 = nil
        end
        s1 << r4
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(HeaderBlock0)
      else
        @index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(HeaderBlockNode,input, i0...index, s0)

    node_cache[:header_block][start_index] = r0

    r0
  end

  def _nt_file_name
    start_index = index
    if node_cache[:file_name].has_key?(index)
      cached = node_cache[:file_name][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?('\G[a-zA-Z_0-9/ \\.]', true, index)
        r1 = true
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:file_name][start_index] = r0

    r0
  end

  module IfaceBlock0
    def s1
      elements[0]
    end

    def ident_name
      elements[2]
    end

    def s2
      elements[3]
    end

    def method_list
      elements[5]
    end

    def s3
      elements[6]
    end

  end

  def _nt_iface_block
    start_index = index
    if node_cache[:iface_block].has_key?(index)
      cached = node_cache[:iface_block][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_s
    s0 << r1
    if r1
      if has_terminal?("interface", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 9))
        @index += 9
      else
        terminal_parse_failure("interface")
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_ident_name
        s0 << r3
        if r3
          r4 = _nt_s
          s0 << r4
          if r4
            if has_terminal?("{", false, index)
              r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("{")
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_method_list
              s0 << r6
              if r6
                r7 = _nt_s
                s0 << r7
                if r7
                  if has_terminal?("}", false, index)
                    r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("}")
                    r8 = nil
                  end
                  s0 << r8
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(InterfaceBlockNode,input, i0...index, s0)
      r0.extend(IfaceBlock0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:iface_block][start_index] = r0

    r0
  end

  def _nt_method_list
    start_index = index
    if node_cache[:method_list].has_key?(index)
      cached = node_cache[:method_list][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_method_decl
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(MethodListNode,input, i0...index, s0)

    node_cache[:method_list][start_index] = r0

    r0
  end

  module MethodDecl0
    def type_name
      elements[0]
    end

    def ident_name
      elements[1]
    end

    def s1
      elements[2]
    end

    def s2
      elements[5]
    end

    def qualifier_list
      elements[7]
    end

    def s3
      elements[8]
    end

  end

  def _nt_method_decl
    start_index = index
    if node_cache[:method_decl].has_key?(index)
      cached = node_cache[:method_decl][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_type_name
    s0 << r1
    if r1
      r2 = _nt_ident_name
      s0 << r2
      if r2
        r3 = _nt_s
        s0 << r3
        if r3
          if has_terminal?("(", false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("(")
            r4 = nil
          end
          s0 << r4
          if r4
            r6 = _nt_param_list
            if r6
              r5 = r6
            else
              r5 = instantiate_node(SyntaxNode,input, index...index)
            end
            s0 << r5
            if r5
              r7 = _nt_s
              s0 << r7
              if r7
                if has_terminal?(")", false, index)
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure(")")
                  r8 = nil
                end
                s0 << r8
                if r8
                  r9 = _nt_qualifier_list
                  s0 << r9
                  if r9
                    r10 = _nt_s
                    s0 << r10
                    if r10
                      if has_terminal?(";", false, index)
                        r11 = instantiate_node(SyntaxNode,input, index...(index + 1))
                        @index += 1
                      else
                        terminal_parse_failure(";")
                        r11 = nil
                      end
                      s0 << r11
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(MethodDeclNode,input, i0...index, s0)
      r0.extend(MethodDecl0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:method_decl][start_index] = r0

    r0
  end

  module ParamList0
    def param_decl
      elements[0]
    end

    def s
      elements[1]
    end

    def param_list
      elements[3]
    end
  end

  def _nt_param_list
    start_index = index
    if node_cache[:param_list].has_key?(index)
      cached = node_cache[:param_list][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_param_decl
    s1 << r2
    if r2
      r3 = _nt_s
      s1 << r3
      if r3
        if has_terminal?(",", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(",")
          r4 = nil
        end
        s1 << r4
        if r4
          r5 = _nt_param_list
          s1 << r5
        end
      end
    end
    if s1.last
      r1 = instantiate_node(ParamListNode,input, i1...index, s1)
      r1.extend(ParamList0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r6 = _nt_param_decl
      if r6
        r0 = r6
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:param_list][start_index] = r0

    r0
  end

  module QualifierList0
    def s
      elements[0]
    end

  end

  def _nt_qualifier_list
    start_index = index
    if node_cache[:qualifier_list].has_key?(index)
      cached = node_cache[:qualifier_list][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_s
    s0 << r1
    if r1
      i2 = index
      if has_terminal?("const", false, index)
        r3 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("const")
        r3 = nil
      end
      if r3
        r2 = r3
      else
        if has_terminal?("", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 0))
          @index += 0
        else
          terminal_parse_failure("")
          r4 = nil
        end
        if r4
          r2 = r4
        else
          @index = i2
          r2 = nil
        end
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(CvQualifierNode,input, i0...index, s0)
      r0.extend(QualifierList0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:qualifier_list][start_index] = r0

    r0
  end

  module ParamDecl0
    def type_name
      elements[0]
    end

    def param_name
      elements[1]
    end
  end

  def _nt_param_decl
    start_index = index
    if node_cache[:param_decl].has_key?(index)
      cached = node_cache[:param_decl][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_type_name
    s0 << r1
    if r1
      r3 = _nt_ident_name
      if r3
        r2 = r3
      else
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(ParamDeclNode,input, i0...index, s0)
      r0.extend(ParamDecl0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:param_decl][start_index] = r0

    r0
  end

  module TypeName0
    def qualifier_list
      elements[0]
    end

    def qualified_type_name
      elements[1]
    end

  end

  def _nt_type_name
    start_index = index
    if node_cache[:type_name].has_key?(index)
      cached = node_cache[:type_name][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_qualifier_list
    s0 << r1
    if r1
      r2 = _nt_qualified_type_name
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          if has_terminal?('*', false, index)
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('*')
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        s0 << r3
        if r3
          if has_terminal?('&', false, index)
            r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('&')
            r6 = nil
          end
          if r6
            r5 = r6
          else
            r5 = instantiate_node(SyntaxNode,input, index...index)
          end
          s0 << r5
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(TypeName0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:type_name][start_index] = r0

    r0
  end

  module QualifiedTypeName0
    def ident_name
      elements[0]
    end

    def s
      elements[1]
    end

    def qualified_type_name
      elements[3]
    end
  end

  def _nt_qualified_type_name
    start_index = index
    if node_cache[:qualified_type_name].has_key?(index)
      cached = node_cache[:qualified_type_name][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_ident_name
    s1 << r2
    if r2
      r3 = _nt_s
      s1 << r3
      if r3
        if has_terminal?("::", false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("::")
          r4 = nil
        end
        s1 << r4
        if r4
          r5 = _nt_qualified_type_name
          s1 << r5
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(QualifiedTypeName0)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r6 = _nt_ident_name
      if r6
        r0 = r6
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:qualified_type_name][start_index] = r0

    r0
  end

  module IdentName0
    def s
      elements[0]
    end

  end

  def _nt_ident_name
    start_index = index
    if node_cache[:ident_name].has_key?(index)
      cached = node_cache[:ident_name][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_s
    s0 << r1
    if r1
      if has_terminal?('\G[a-zA-Z_]', true, index)
        r2 = true
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          if has_terminal?('\G[a-zA-Z0-9_]', true, index)
            r4 = true
            @index += 1
          else
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(IdentifierNode,input, i0...index, s0)
      r0.extend(IdentName0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:ident_name][start_index] = r0

    r0
  end

  def _nt_s
    start_index = index
    if node_cache[:s].has_key?(index)
      cached = node_cache[:s][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_space
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:s][start_index] = r0

    r0
  end

  def _nt_S
    start_index = index
    if node_cache[:S].has_key?(index)
      cached = node_cache[:S][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_space
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:S][start_index] = r0

    r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if has_terminal?('\G[ \\t\\n\\r]', true, index)
      r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r0 = nil
    end

    node_cache[:space][start_index] = r0

    r0
  end

end

class DuckfaceParser < Treetop::Runtime::CompiledParser
  include Duckface
end


