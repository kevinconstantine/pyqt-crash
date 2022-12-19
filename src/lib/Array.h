//
// Array.h
//

#ifndef __Array__
#define __Array__

#include <iostream>
#include <QtCore/QtCore>
#include <memory>

namespace mylib {

class Array;
typedef std::shared_ptr< Array > arrayptr_t;

class Q_DECL_EXPORT Array : public QObject {
	Q_OBJECT

	protected:

	public:
		Array(int did = 0);
		~Array();
		int GetAid();
		void SetAid(int);
	private:
		int m_aid;
};
};
#endif
