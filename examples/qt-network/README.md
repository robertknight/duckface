## Qt Network Download

This example shows the use of duckface interfaces to create an abstraction of a
class in a 3rd-party library in order to make a function more easily testable.

`NetworkAccess.if.h` defines two interfaces, `NetworkAccess` and `NetworkReply` which
provide the interfaces required to perform an HTTP GET request and download a file.

These interfaces match the existing `QNetworkAccessManager` and `QNetworkReply` classes in Qt.

The `downloadFile()` function takes a `NetworkAccess` instance which it uses to fetch a file and
dump the output to stdout.  In a unit test, or for debugging purposes, the 'real' network
instance can easily be replaced by a simple mock class which implements the methods in the
`NetworkAccess` and `NetworkReply` interfaces and returns canned input.

## Building and Running the Example

This example uses Qt's qmake build system.  You can build it on a Mac/Linux system using:

    qmake
	make
	./qttest
