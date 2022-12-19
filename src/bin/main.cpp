#include "DGraph.h"

using namespace mylib;

int main([[maybe_unused]] int argc, [[maybe_unused]] char * argv[]) {
	std::cout << "cpp main: Hello from Main!" << std::endl;
	DGraph dg;
	arrayptr_t a = arrayptr_t(new Array());
	int aid = dg.AddArray(a);
	std::cout << "cpp main: aid = " << aid << std::endl;
	return 0;
}
