#pragma once

// this file was automatically generated from Writer.if.h
// by duckface



template <class T>
class WriterIface;
class WriterIfaceBase;

class Writer
{
public:
	/** Construct a Writer pointer from an object of type T.
	  * Calling this method will produce a compile-time error if T lacks
	  * one or more of the methods in this interface.
	  */
	template <class T>
	Writer(T* object);
	Writer();

	// methods declared in the Writer interface
	int write(const char* data, int len);

	/** Operator to allow Writer instances to be accessed like pointer
	  * classes (eg. using interfacePtr->someMethod() instead of interfacePtr.someMethod())
	  */
	Writer* operator->() {
		return this;
	}

	// Equality operators.  Two interface pointers are equal if they refer
	// to the same underlying object.
	bool operator==(const Writer& other) const;
	bool operator!=(const Writer& other) const;

	template <class T>
	bool operator==(T* other) const;
	template <class T>
	bool operator!=(T* other) const;

	operator bool() const;

	// access to the underlying object
	void* data();
	const void* data() const;

	// destroy the underlying object
	void destroy();

private:
	WriterIfaceBase* m_impl;
	void* m_obj;
};

// Base class for classes which implement method dispatch for Writer.  There is one
// WriterIfaceBase instance per concrete-type.
class WriterIfaceBase
{
public:
	virtual int write(void* inst, const char* data, int len)  = 0;
	virtual void destroy(void* inst) = 0;
};

template <class T>
class WriterIface : public WriterIfaceBase
{
public:
	virtual int write(void* inst, const char* data, int len)  {
		return static_cast<T*>(inst)->write(data, len);
	}
	virtual void destroy(void* inst) {
		delete static_cast<T*>(inst);
	}

	static WriterIface<T>* instance() {
		static WriterIface<T> inst;
		return &inst;
	}
};

template <class T>
inline Writer::Writer(T* inst)
: m_impl(WriterIface<T>::instance())
, m_obj(inst)
{
}

inline Writer::Writer()
: m_impl(0)
, m_obj(0)
{
}

inline int Writer::write(const char* data, int len) 
{
	return m_impl->write(m_obj, data, len);
}

void Writer::destroy()
{
	m_impl->destroy(m_obj);
	m_obj = 0;
}

inline bool Writer::operator==(const Writer& other) const
{
	return m_obj == other.m_obj;
}

inline bool Writer::operator!=(const Writer& other) const
{
	return m_obj != other.m_obj;
}

inline Writer::operator bool() const
{
	return m_obj != 0;
}

template <class T>
inline bool Writer::operator==(T* other) const
{
	return m_obj == other;
}

template <class T>
inline bool Writer::operator!=(T* other) const
{
	return m_obj != other;
}

inline void* Writer::data()
{
	return m_obj;
}

const void* Writer::data() const
{
	return m_obj;
}

