
#include "NetworkAccess.h"

#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkAccessManager>
#include <QtCore/QUrl>
#include <QtCore/QCoreApplication>

#include <iostream>

// mock implementations of the NetworkAccess interfaces
// for use in a test.  The mock implementation always successfully
// returns a canned blob of text

// MockNetworkReply implements the NetworkReply interface
struct MockNetworkReply : public QObject {
	bool read;

	MockNetworkReply() {
		read = false;
	};

	QByteArray readAll() {
		read = true;
		return "test content";
	}

	bool waitForReadyRead(int) {
		return true;
	}

	bool isFinished() {
		return read;
	}
};

struct MockNetworkAccess {
	// get() returns a MockNetworkReply instance which will
	// be converted to a NetworkReply instance when used via
	// NetworkAccess::get()
	MockNetworkReply* get(const QNetworkRequest&) {
		return new MockNetworkReply;
	}
};

// function which downloads a file using a NetworkAccess instance
// and dumps the result to stdout
void downloadFile(const QUrl& url, NetworkAccess network)
{
	QNetworkRequest request(url);
	NetworkReply reply = network->get(request);

	QByteArray content;
	while (!reply->isFinished()) {
		reply->waitForReadyRead(-1);
		content += reply->readAll();
		QCoreApplication::processEvents();
	}
	content += '\0';

	std::cout << content.data() << std::endl;
	reply->deleteLater();
}

int main(int argc, char** argv)
{
	QCoreApplication app(argc,argv);

	// change the argument to the downloadFile() function
	// between 'realNetwork' and 'mockNetwork' to switch between
	// the real and simulated network
	QNetworkAccessManager realNetwork;
	MockNetworkAccess mockNetwork;

	downloadFile(QUrl("http://www.google.com"),&mockNetwork);

	return 0;
}

