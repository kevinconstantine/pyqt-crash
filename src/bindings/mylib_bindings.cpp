#include <Python.h>
#include <sip.h>
#include "mylib_bindings.h"

static PyObject *cleanup_on_exit(PyObject *, PyObject *)
{
	printf("KCC cleanup_on_exit\n");
	Py_INCREF(Py_None);
	return Py_None;
}

// Perform any required initialisation.
void mylib_init()
{
	printf("KCC mylib_init\n");
    // Register the cleanup function.
    static PyMethodDef cleanup_md = {
        "_mylib_cleanup", cleanup_on_exit, METH_NOARGS, SIP_NULLPTR
    };

    api_register_exit_notifier(&cleanup_md);

}
