//
//  DGraph.cpp
//

#include "DGraph.h"

using namespace mylib;

DGraph::DGraph([[maybe_unused]] int did) : QObject() {
	std::cout << "cpp: DGraph Constructor " << this << std::endl;
}

DGraph::~DGraph() {
	std::cout << "cpp: DGraph Destructor " << this << std::endl;
}

int DGraph::AddArray(arrayptr_t a) {
	std::cout << "cpp: DGraph AddArray() " << std::endl;
	int newaid = m_arraylist.size() + 1;
	a->SetAid(newaid);
	m_arraylist[newaid] = a;
	return a->GetAid();
}
