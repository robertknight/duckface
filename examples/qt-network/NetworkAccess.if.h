#include <QtCore/QByteArray>

class QNetworkRequest;

interface NetworkReply {
	void deleteLater();
	QByteArray readAll();
	bool waitForReadyRead(int timeout);
	bool isFinished();
}

interface NetworkAccess {
	NetworkReply get(const QNetworkRequest& request);
}
