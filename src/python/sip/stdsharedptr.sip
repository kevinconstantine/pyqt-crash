// std::shared_ptr< T >

// need to create a little shim class to keep track of the std::shared_ptrs and hold on to them
// the Python will take the raw reference, and when it deletes it, we'll delete the std::shared_ptr

%ModuleHeaderCode
#include <memory>
#include <QHash>
#include <iostream>

template <class T>
class stdSPRepo {
	static QHash< T *, std::shared_ptr< T > > pointerMap;
public:
	static void addToMap(std::shared_ptr< T > &ptr) {
		pointerMap.insert(ptr.get(), ptr);
	}

	static bool contains(T *rPtr) {
		return pointerMap.contains(rPtr);
	}
	
	static std::shared_ptr< T > &getReference(T *rPtr) {
		if (pointerMap.contains(rPtr)) {
			return pointerMap[rPtr];
		}
	}

	static void removeFromMap(T *rPtr) {
		pointerMap.remove(rPtr);
	}
};

template <class T> QHash< T *, std::shared_ptr< T > > stdSPRepo<T>::pointerMap;
%End

template<TYPE>
%MappedType std::shared_ptr< TYPE > {

%ConvertFromTypeCode
	if (!sipCpp) { // is the returning pointer good?
		std::cout << "Return None" << std::endl;
		return Py_None;
	}
	std::cout << "ConvertFromTypeCode 1" << std::endl;
	std::shared_ptr< TYPE > *ptr = reinterpret_cast<std::shared_ptr< TYPE > * >(sipCpp); // re-cast to the right object
	if (!(*ptr)) { // does the shared pointer contain anything?
		std::cout << "Return None" << std::endl;
		return Py_None;
	}
	stdSPRepo< TYPE >::addToMap(*ptr);
	// explicit (void *) cast allows TYPE to be const
	std::cout << "sip ConvertFromTypeCode" << " " << (void *)ptr->get() << " " << sipType_TYPE << " " << std::endl;
	return sipConvertFromType((void *)ptr->get(), sipType_TYPE, Py_None); // send the pointer up
%End

%ConvertToTypeCode
	if (sipIsErr == NULL) { // type checking
		if ((sipPy == NULL) || (!sipCanConvertToType(sipPy, sipType_TYPE, 0))) { // if the pointer is null, or not the right type, don't convert
			return 0;
		}
		return 1;
	}
	std::cout << "shared_ptr_sip: sipConvertToType() call" << std::endl;
	TYPE *dg = reinterpret_cast< TYPE * >(sipConvertToType(sipPy, sipType_TYPE, 0, 0, 0, sipIsErr)); // convert it to the raw type
	std::shared_ptr< TYPE > *ptr;
	std::cout << "shared_ptr_sip: addresses *dg " << dg << " *ptr " << ptr << std::endl;
	if (stdSPRepo< TYPE >::contains(dg)) { // do we already have a reference to it?
		std::cout << "shared_ptr_sip: stdSPRepo already contains dg" << std::endl;
		ptr = new std::shared_ptr< TYPE >(stdSPRepo< TYPE >::getReference(dg)); // return a new reference to the shared pointer
	}
	else { // make a new shared pointer and return that...
		std::cout << "shared_ptr_sip: Making a new shared pointer" << std::endl;
		ptr = new std::shared_ptr< TYPE >(dg);
		std::cout << "shared_ptr_sip: dg " << dg << " ptr " << ptr << std::endl;
		stdSPRepo< TYPE >::addToMap(*ptr);
	}
	*sipCppPtr = ptr;
	std::cout << "shared_ptr_sip: ConvertToTypeCode sipCppPtr " << sipCppPtr << " ptr " << ptr  << std::endl;
	return SIP_TEMPORARY;
%End

};

template< TYPE >
%MappedType QList< std::shared_ptr< TYPE > >
{

%ConvertFromTypeCode
	if (!sipCpp) { // is the returning pointer any good?
		return Py_None;
	}

	std::cout << "ConvertFromTypeCode 2" << std::endl;
    // Create the list.
    PyObject *l;

    if ((l = PyList_New(sipCpp->size())) == NULL)
        return NULL;

    // Set the list elements.
    for (int i = 0; i < sipCpp->size(); ++i)
    {
        std::shared_ptr< TYPE > ptr = sipCpp->at(i);
		if (ptr) {
			stdSPRepo< TYPE >::addToMap(ptr); // stash away a reference to it...

			// The explicit (void *) cast allows coda::TYPE to be const.
			PyObject *tobj;
			if ((tobj = sipConvertFromType((void *)ptr.get(), sipType_TYPE, Py_None)) != NULL) { // good conversion
				PyList_SET_ITEM(l, i, tobj);
			}
			else {
				Py_DECREF(l);
				return NULL;
			}
		}
    }
    return l; // return the list
%End

%ConvertToTypeCode
    SIP_SSIZE_T len;

	std::cout << "ConvertToTypeCode 2" << std::endl;
    // Check the type if that is all that is required.
    if (sipIsErr == NULL)
    {
        if (!PySequence_Check(sipPy) || (len = PySequence_Size(sipPy)) < 0)
            return 0;

        for (SIP_SSIZE_T i = 0; i < len; ++i)
        {
            PyObject *itm = PySequence_ITEM(sipPy, i);
            bool ok = (itm && sipCanConvertToType(itm, sipType_TYPE, 0));

            Py_XDECREF(itm);

            if (!ok)
                return 0;
        }

        return 1;
    }

    QList< std::shared_ptr < TYPE > > *ql = new QList< std::shared_ptr < TYPE > >;
    len = PySequence_Size(sipPy);
 
    for (SIP_SSIZE_T i = 0; i < len; ++i)
    {
        PyObject *itm = PySequence_ITEM(sipPy, i);
		TYPE *dg = reinterpret_cast< TYPE * >(sipConvertToType(itm, sipType_TYPE, sipTransferObj, 0, 0, sipIsErr));

        Py_DECREF(itm);

        if (*sipIsErr) {
            delete ql;
            return 0;
        }

		std::shared_ptr< TYPE > *ptr;
		if (stdSPRepo< TYPE >::contains(dg)) { // do we already have a reference to it?
			ptr = new std::shared_ptr< TYPE >(stdSPRepo< TYPE >::getReference(dg)); // return a new reference to the shared pointer
		}
		else { // make a new shared pointer and return that...
			ptr = new std::shared_ptr< TYPE >(dg);
			stdSPRepo< TYPE >::addToMap(*ptr);
		}

        ql->append(*ptr);
    }
 
    *sipCppPtr = ql;
 
    return sipGetState(sipTransferObj);
%End

};

