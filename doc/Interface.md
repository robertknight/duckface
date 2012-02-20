# Interface File Specification

Interface files consist of a header followed by interface declarations.
Interface files have `.if.h` extensions and the corresponding generated headers
have the same base name but a `.h` extension.

## Header

The header consists of all text from the top of the file, up until the first occurrence of
the keyword "interface".  It is copied into the generated header file verbatim.

The header typically contains includes and forward declarations required for types
referenced in interface method declarations.

## Interface declarations

Interface declarations are similar to C++ struct definitions, except that they
begin with the word 'interface' rather than 'struct' and can only contain
a list of methods.  Constants, member variables, access specifiers etc. are
not permitted.  Interface blocks do not require a trailing semi-colon,
but method declarations do.

    interface InterfaceName {
        return-type method-name (parameter-list) qualifiers;
        ...
    }

Type names and parameter lists use the same syntax as in a C++ struct, except
that there is currently no support for certain kinds of type, including function pointers,
member function pointers or types with template arguments.

A single interface file may declare multiple interfaces.

## Examples

An interface for iterating over the contents of a directory:

    #include <string>

    interface DirIterator {
        bool next();
        std::string filePath() const;
    }

