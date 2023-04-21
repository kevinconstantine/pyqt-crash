TEMPLATE = lib
TARGET = mylib

QT -= gui

HEADERS += Array.h DGraph.h

SOURCES += Array.cpp DGraph.cpp

DESTDIR = $$top_builddir/build/lib
target.path += $$top_builddir/install/usr/lib64
#target.path += $$(VIRTUAL_ENV)/lib
INSTALLS += target
