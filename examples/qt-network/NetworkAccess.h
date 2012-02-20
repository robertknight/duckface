#pragma once

// this file was automatically generated from NetworkAccess.if.h
// by duckface

#include <QtCore/QByteArray>

class QNetworkRequest;

template <class T>
class NetworkReplyIface;
class NetworkReplyIfaceBase;

class NetworkReply
{
public:
	/** Construct a NetworkReply pointer from an object of type T.
	  * Calling this method will produce a compile-time error if T lacks
	  * one or more of the methods in this interface.
	  */
	template <class T>
	NetworkReply(T* object);

	// methods declared in the NetworkReply interface
	void deleteLater();
	QByteArray readAll();
	bool waitForReadyRead(int timeout);
	bool isFinished();

	/** Operator to allow NetworkReply instances to be accessed like pointer
	  * classes (eg. using interfacePtr->someMethod() instead of interfacePtr.someMethod())
	  */
	NetworkReply* operator->() {
		return this;
	}

private:
	NetworkReplyIfaceBase* m_impl;
	void* m_obj;
};
template <class T>
class NetworkAccessIface;
class NetworkAccessIfaceBase;

class NetworkAccess
{
public:
	/** Construct a NetworkAccess pointer from an object of type T.
	  * Calling this method will produce a compile-time error if T lacks
	  * one or more of the methods in this interface.
	  */
	template <class T>
	NetworkAccess(T* object);

	// methods declared in the NetworkAccess interface
	NetworkReply get(const QNetworkRequest& request);

	/** Operator to allow NetworkAccess instances to be accessed like pointer
	  * classes (eg. using interfacePtr->someMethod() instead of interfacePtr.someMethod())
	  */
	NetworkAccess* operator->() {
		return this;
	}

private:
	NetworkAccessIfaceBase* m_impl;
	void* m_obj;
};

// Base class for classes which implement method dispatch for NetworkReply.  There is one
// NetworkReplyIfaceBase instance per concrete-type.
class NetworkReplyIfaceBase
{
public:
	virtual void deleteLater(void* inst)  = 0;
	virtual QByteArray readAll(void* inst)  = 0;
	virtual bool waitForReadyRead(void* inst, int timeout)  = 0;
	virtual bool isFinished(void* inst)  = 0;
};

template <class T>
class NetworkReplyIface : public NetworkReplyIfaceBase
{
public:
	virtual void deleteLater(void* inst)  {
		static_cast<T*>(inst)->deleteLater();
	};
	virtual QByteArray readAll(void* inst)  {
		return static_cast<T*>(inst)->readAll();
	};
	virtual bool waitForReadyRead(void* inst, int timeout)  {
		return static_cast<T*>(inst)->waitForReadyRead(timeout);
	};
	virtual bool isFinished(void* inst)  {
		return static_cast<T*>(inst)->isFinished();
	};

	static NetworkReplyIface<T>* instance() {
		static NetworkReplyIface<T> inst;
		return &inst;
	}
};

template <class T>
inline NetworkReply::NetworkReply(T* inst)
: m_impl(NetworkReplyIface<T>::instance())
, m_obj(inst)
{
}

inline void NetworkReply::deleteLater() 
{
	m_impl->deleteLater(m_obj);
}
inline QByteArray NetworkReply::readAll() 
{
	return m_impl->readAll(m_obj);
}
inline bool NetworkReply::waitForReadyRead(int timeout) 
{
	return m_impl->waitForReadyRead(m_obj, timeout);
}
inline bool NetworkReply::isFinished() 
{
	return m_impl->isFinished(m_obj);
}
// Base class for classes which implement method dispatch for NetworkAccess.  There is one
// NetworkAccessIfaceBase instance per concrete-type.
class NetworkAccessIfaceBase
{
public:
	virtual NetworkReply get(void* inst, const QNetworkRequest& request)  = 0;
};

template <class T>
class NetworkAccessIface : public NetworkAccessIfaceBase
{
public:
	virtual NetworkReply get(void* inst, const QNetworkRequest& request)  {
		return static_cast<T*>(inst)->get(request);
	};

	static NetworkAccessIface<T>* instance() {
		static NetworkAccessIface<T> inst;
		return &inst;
	}
};

template <class T>
inline NetworkAccess::NetworkAccess(T* inst)
: m_impl(NetworkAccessIface<T>::instance())
, m_obj(inst)
{
}

inline NetworkReply NetworkAccess::get(const QNetworkRequest& request) 
{
	return m_impl->get(m_obj, request);
}

