//
// SIP wrapper for mylib
//

%Module mylib

%Import QtCore/QtCoremod.sip
%Include stdsharedptr.sip

namespace mylib {

	typedef std::shared_ptr< mylib::Array > arrayptr_t;
	typedef QHash< QString, int > hashint_t;

	//%Module Array
	class Array : QObject {

		%TypeHeaderCode
		#include <Array.h>
		%End

		public:
			Array(int did = 0);
			%MethodCode
				printf("mylib SIP Array Constructor\n");
			    try
				{
				sipCpp = new sipmylib_Array(a0);
				}
				catch (...)
				{
					sipRaiseUnknownException();
					return SIP_NULLPTR;
				}
			%End
			~Array();
			%MethodCode
				printf("mylib SIP Array Destructor 0x%x\n", sipCpp);
				if (stdSPRepo< mylib::Array >::contains(sipCpp)) {
					stdSPRepo< mylib::Array >::removeFromMap(sipCpp);
					return;
				}
			%End
			int GetAid();
			void SetAid(int);
		private:
			Array(const Array &);
			Array &operator=(const Array &);
	};

	//%Module DGraph

	class DGraph : QObject {

		%TypeHeaderCode
		#include <DGraph.h>
		%End

		public:
			DGraph(int did = 0);
			~DGraph();
			%MethodCode
				printf("mylib SIP DGraph Destructor 0x%x\n", sipCpp);
				if (stdSPRepo< mylib::DGraph >::contains(sipCpp)) {
					stdSPRepo< mylib::DGraph >::removeFromMap(sipCpp);
					return;
				}
			%End
			int AddArray(arrayptr_t);
		private:
			DGraph(const DGraph &);
			DGraph &operator=(const DGraph &);
	};
}; // mylib namespace
