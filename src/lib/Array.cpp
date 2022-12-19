//
//  Array.cpp
//

#include "Array.h"

using namespace mylib;

Array::Array([[maybe_unused]] int did) : QObject() {
	std::cout << "cpp: Array Constructor " << this << std::endl;
	m_aid = 0;
}

Array::~Array() {
	std::cout << "cpp: Array Destructor " << this << std::endl;
}

int Array::GetAid() {
	return(m_aid);
}

void Array::SetAid(int newaid) {
	m_aid = newaid;
}
