TEMPLATE = lib
TARGET = mylib

QT -= gui

HEADERS += Array.h DGraph.h

SOURCES += Array.cpp DGraph.cpp

DESTDIR = $$top_builddir/build/lib
target.path += $$top_builddir/install/lib
INSTALLS += target