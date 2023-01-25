TEMPLATE = app

QT -= gui

HEADERS += 
SOURCES += main.cpp

INCLUDEPATH = ../lib
LIBS += -L$$top_builddir/build/lib -lmylib
QMAKE_RPATHDIR = ../lib
DESTDIR = $$top_builddir/build/bin

TARGET=mylibbin
#target.path = $$top_builddir/install/bin
target.path = $$[QT_INSTALL_BINS]
INSTALLS += target
