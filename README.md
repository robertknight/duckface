duckface is a simple tool which provides a way to create and use interfaces in C++ without
the need to modify classes in order for them to implement the interface (as inheritance requires)
or make users of the interface dependent on template arguments.

The approach is based on interfaces in the Go language.  In Go, types do not explicitly
declare that they implement interfaces, instead an interface is just a set of methods and
an *interface value* can hold a reference to any type which implements the methods in the interface.
The lack of requirement to specify whether a type implements a particular interface makes this a kind of duck-typing
(hence the name of the project).

duckface is a tool which creates C++ classes (known as an *interface pointers*) that can emulate this behavior.

## How it Works

The `duckface.rb` tool reads an interface file (typically named `InterfaceName.if.h`) which declares a set of
interfaces using a syntax very similar to C++ struct declarations.  Each interface specifies a set of methods
which compatible classes must implement in order to 'implement' the interface.  `duckface.rb` then generates
a header file which declares an *interface pointer* class with the same name as the interface.  Instances of this class can
wrap a pointer to any type which implements the methods in the interface.  Any of the matching methods can then be
called via the *interface pointer*.

## Example Usage

 1. Create a file named `Stringer.if.h` where we'll declare an interface for getting the string representation of an object.

        #include <string>

        interface Stringer {
            std::string toString() const;
        }

 2. Run `duckface.rb Stringer.if.h` to create the `Stringer` class, which is an interface pointer that
    can wrap any object which has a compatible `toString()` method.

 3. Use the generated `Stringer` class to wrap a suitable class:

        #include "Stringer.h"
        #include <iostream>

        struct Foo {
            std::string toString() const {
                return "foo";
            }
        };

        int main(int, char**)
        {
            Foo foo;
            Stringer s(&foo);

            // call foo.toString() via the Stringer interface
            std::cout << s->toString() << std::endl;
            return 0;
        }

## Use Cases

duckface interfaces are an alternative to standard single or multiple inheritance or templates.

 * Compared to single/multiple inheritance in C++, there is no need to modify an existing class in order for it
   to implement an interface.  This is especially useful when the existing classes are part of third-party libraries
   which are difficult to modify.  It is often the case that a library of classes may conform to a convention (such as
   providing a `toString()` method to get a string representation of the object) but do not explicitly implement a common
   interface.
 * Compared to templates, there is no need to make the function or class which uses an interface dependent on template
   arguments or for all code which uses the interface to be placed in a header file.  Additionally, it is made explicit which
   set of methods a user of an interface can access.  With templates, this information is only present in the documentation and
   in compile-time errors when attempting to instantiate a template with a type that does not meet the requirements.

## Dependencies

 * The generated classes have no compile or runtime dependencies, other than those for the types used in interface methods.
 * The `duckface.rb` tool uses Ruby and the treetop and mustache gems.

## Performance

 * Interface pointers are twice the size of normal pointers.  They contain two pointers, one to the underlying object and
   another to a dispatch class for the (concrete-type,interface) pair involved.  This is similar to the implementation of interface values in Go.
 * Method calls on interface pointers require a single virtual function call.
 * For each distinct (concrete-type,interface) pair, a dispatch class instance is created to invoke method calls for
   that interface and underlying concrete-type.

## Limitations

 * There is currently no support for templates in interface declarations
 * When constructing an interface pointer, the compiler only checks that for each method in the
   interface, there is a method of the same name with compatible types in the concrete type.
   A method in the concrete type which uses different, but compatible types, will not result
   in a compile-time error but could result in unexpected behavior at runtime.
 * Interface pointers currently wrap only the raw pointer and not shared or unique pointers, so,
   for example, it is not possible to have an interface pointer increment a reference count when
   it is constructed and decrement it when destroyed.
 * Argument and return types in method declarations cannot currently be function pointers,
   member function pointers or include template arguments.

## Further Reading

   1. [Go Language Specification: Interface Types](http://golang.org/doc/go_spec.html#Interface_types)
   2. [Ian Lance Taylor: Go Interfaces](http://www.airs.com/blog/archives/277)
   3. [Signatures: A language extension for improving type abstraction and subtype polymorphism in C++](http://www.mendeley.com/research/signatures-language-extension-improving-type-abstraction-subtype-polymorphism-c/) (This is a paper from 1995 which implements a more sophisticated version of the interfaces generated by duckface as a gcc compiler extension.  It was integrated into gcc 2.95 as a language extension but is no longer included in recent versions.)

