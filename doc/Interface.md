# Interface File Specification

Interface files consist of include declarations and interface declarations.
Interface files have `.if.h` extensions and the corresponding generated headers
have the same base name but a `.h` extension.

## Include declarations

Include declarations include any headers that declare types used in interface methods.

Include declarations are the same as in normal C++ header files, consisting
of `#include` followed by the header name in angle brackets or quotes.

    #include <FileName>
    #include "FileName"

Include declarations are always placed at the top of generated headers, regardless
of where they appear in the interface file.

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

