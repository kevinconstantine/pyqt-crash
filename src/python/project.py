import subprocess
import os
from os.path import join
from pyqtbuild import PyQtBindings, PyQtProject
from sipbuild import Option
import PyQt5


class mylib(PyQtProject):

    def __init__(self):
        """ Initialise the project. """

        super().__init__()
        self.bindings_factories = [mylibQt5Bindings]

    def update(self, tool):
        """Allows SIP to find PyQt5 .sip files."""
        super().update(tool)
        self.sip_include_dirs.append(join(PyQt5.__path__[0], 'bindings'))

    def get_module_extension(self):
        return ".so"

class mylibQt5Bindings(PyQtBindings):
    """The mylib Bindings class."""

    def __init__(self, project):
        super().__init__(project, name='mylib-Qt5', sip_file='mylib.sip', qmake_QT=['xml'])

    def apply_user_defaults(self, tool):

        self.exceptions = True

        # Set include_dirs, library_dirs and libraries based on pkg-config data
        src_python = os.path.dirname(os.path.abspath(__file__))
        src = os.path.dirname(src_python)
        root = os.path.dirname(src)
        self.include_dirs.append(os.path.join(src, 'lib'))
        self.include_dirs.append(os.path.join(src, 'bindings'))
        self.include_dirs.append(os.path.join(root, 'build', 'lib'))
        self.library_dirs.append(os.path.join(root, 'build', 'lib'))
        self.libraries.append("mylib")
        self.libraries.append("mylib_bindings")
        super().apply_user_defaults(tool)
