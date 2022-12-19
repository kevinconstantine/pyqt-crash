TEMPLATE = app
TARGET = sip/mylib.so

SIPFILE = mylib.sip
QMAKE_CLEAN = sip

sip.commands = 'mkdir -p sip; cd sip && python ../configure.py -f ../$$SIPFILE && $(MAKE)'
sip.target = sip/mylib.so
sip.depends = mylib.sip stdsharedptr.sip configure.py

QMAKE_EXTRA_TARGETS += sip
target.path = $$top_builddir/install/lib
INSTALLS += target
