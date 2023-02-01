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
        self.abi_version = "12.9"

    def update(self, tool):
        """Allows SIP to find PyQt5 .sip files."""
        super().update(tool)
        self.sip_include_dirs.append(join(PyQt5.__path__[0], 'bindings'))

    def get_module_extension(self):
        print("KCC PRIVATE EXTENSION")
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
        super().apply_user_defaults(tool)


'''
class Qsci(PyQtBindings):
    """ The Qsci bindings. """

    def __init__(self, project):
        """ Initialise the bindings. """

        if project.qsci_external_lib:
            qmake_CONFIG = ['qscintilla2']
        else:
            qmake_CONFIG = []

        super().__init__(project, 'Qsci', qmake_CONFIG=qmake_CONFIG)

    def apply_user_defaults(self, tool):
        """ Set default values for user options that haven't been set yet. """

        project = self.project
        qt6 = (project.builder.qt_version >= 0x060000)

        # Set the name of the .sip file now that we know the Qt version number.
        self.sip_file = 'mylib.sip'

        if self.project.qsci_external_lib:
            if self.qsci_features_dir is not None:
                os.environ['QMAKEFEATURES'] = os.path.abspath(
                        self.qsci_features_dir)

            if self.qsci_include_dir is not None:
                self.include_dirs.append(
                        os.path.abspath(self.qsci_include_dir))

            if self.qsci_library_dir is not None:
                self.library_dirs.append(
                        os.path.abspath(self.qsci_library_dir))
        else:
            # We configure CONFIG and QT textually because it's too late to
            # update qmake_CONFIG and qmake_QT.
            self.builder_settings.append('QT += widgets')

            if project.py_platform != 'ios':
                self.builder_settings.append('QT += printsupport')

            if project.py_platform in ('darwin', 'ios') and not qt6:
                self.builder_settings.append('QT += macextras')

            self.builder_settings.append(
                    'CONFIG += warn_off thread exceptions')

            self.define_macros.extend(
                    ['SCINTILLA_QT', 'SCI_LEXER',
                        'INCLUDE_DEPRECATED_FEATURES'])

            self._add_internal_lib_sources()

        super().apply_user_defaults(tool)

    def get_options(self):
        """ Return the list of configurable options. """

        options = super().get_options()

        if self.project.qsci_external_lib:
            # The directory containing the features file.
            options.append(
                    Option('qsci_features_dir',
                            help="the qscintilla2.prf features file is in DIR",
                            metavar="DIR"))

            # The directory containing the include directory.
            options.append(
                    Option('qsci_include_dir',
                            help="the Qsci include file directory is in DIR",
                            metavar="DIR"))

            # The directory containing the library.
            options.append(
                    Option('qsci_library_dir',
                            help="the QScintilla library is in DIR",
                            metavar="DIR"))

        return options

    def handle_test_output(self, test_output):
        """ Handle the output from the external test program and return True if
        the bindings are buildable.
        """

        project = self.project

        installed_version = int(test_output[0])
        installed_version_str = test_output[1]

        if project.version != installed_version:
            project.progress(
                    "QScintilla v{0} is required but QScintilla v{1} is "
                    "installed.".format(project.version_str,
                            installed_version_str))
            return False

        return True

    def is_buildable(self):
        """ Return True if the bindings are buildable. """

        # We need to check the compatibility of an external QScintilla library.
        if self.project.qsci_external_lib:
            return super().is_buildable()

        return True

    def _add_dir_sources(self, dname):
        """ Add the headers and sources from a particular directory. """

        for fn in os.listdir(dname):
            # Skip the printer support on iOS.
            if self.project.py_platform == 'ios' and fn.startswith('qsciprinter.'):
                continue

            if fn.endswith('.h'):
                self.headers.append(os.path.join(dname, fn))
            elif fn.endswith('.cpp'):
                self.sources.append(os.path.join(dname, fn))

    def _add_internal_lib_sources(self):
        """ Add to the lists of include directories, header files and source
        files to build the QScintilla library.
        """

        include_dirs = ['src']

        for dn in ('include', 'lexers', 'lexlib', 'src'):
            include_dirs.append(os.path.join('scintilla', dn))

        self._add_dir_sources(os.path.join('src', 'Qsci'))

        for dn in include_dirs:
            self._add_dir_sources(dn)

        self.include_dirs.extend(include_dirs)
'''
