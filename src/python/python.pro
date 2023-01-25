TEMPLATE = app
TARGET = mylib.built

sip.commands = 'sip-install --verbose; touch mylib.built'
sip.target = mylib.built
sip.path = $$top_builddir/install/mylib.built
sip.depends = sip/mylib.sip sip/stdsharedptr.sip project.py pyproject.toml README

QMAKE_EXTRA_TARGETS += sip
INSTALLS += sip

QMAKE_CLEAN += mylib.built
QMAKE_DISTCLEAN += mylib.built
