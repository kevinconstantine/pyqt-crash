//
// DGraph.h
//

#ifndef __DGraph__
#define __DGraph__

#include <iostream>
#include <QtCore/QtCore>
#include <QHash>
#include <memory>
#include "Array.h"

namespace mylib {

class DGraph : public QObject {
	Q_OBJECT

	protected:
		QHash< int, arrayptr_t > m_arraylist;

	public:
		DGraph(int did = 0);
		~DGraph();
		int AddArray(arrayptr_t);
};
};
#endif
