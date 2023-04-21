TEMPLATE = app
TARGET = mylib.built

PYTHON_SITELIB = $$system(python -c \'from distutils.sysconfig import get_python_lib; print(get_python_lib(1))\')
INSTALL_DIR = $$top_builddir/install/$${PYTHON_SITELIB}

sip.commands = "sip-install --qmake /usr/bin/qmake-qt5 --target-dir $${INSTALL_DIR}  --verbose; touch mylib.built"
sip.target = mylib.built
sip.path = $$top_builddir/install/mylib.built
sip.depends = sip/mylib.sip sip/stdsharedptr.sip project.py pyproject.toml README

QMAKE_EXTRA_TARGETS += sip
INSTALLS += sip

QMAKE_CLEAN += mylib.built
QMAKE_DISTCLEAN += mylib.built
