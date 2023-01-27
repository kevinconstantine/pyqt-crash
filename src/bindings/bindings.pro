TEMPLATE = lib
TARGET = mylib_bindings

QT -= gui

INCLUDEPATH += /disk1/scratch/isobuild/Linux-3.10.0-x86_64-optimize/include/python3.7m/
HEADERS +=  mylib_bindings.h
 
SOURCES += mylib_bindings.cpp

DESTDIR = $$top_builddir/build/lib
#target.path += $$top_builddir/install/lib
target.path += $$(VIRTUAL_ENV)/lib
INSTALLS += target
