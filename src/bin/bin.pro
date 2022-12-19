TEMPLATE = app

QT -= gui

HEADERS += 
SOURCES += main.cpp

INCLUDEPATH = ../lib
LIBS += -L$$top_builddir/build/lib -lmylib
QMAKE_RPATHDIR = $$top_builddir/build/lib
DESTDIR = $$top_builddir/build/bin

target.path = $$top_builddir/install/bin
INSTALLS += target
