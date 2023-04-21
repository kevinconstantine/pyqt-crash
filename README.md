Expectation
------------
RHEL9 machine
Python3 is available
Qt5 is available

Building Reproducer
--------
```
qmake-qt5
make install
```

Testing
--------
```
export PYTHONPATH=install/usr/lib64/python3.9/site-packages/
export LD_LIBRARY_PATH=install/usr/lib64
export PATH=install/usr/bin:$PATH

# test.py should crash on exit
./test.py

# test-cleanup.py should NOT crash on exit
# we are deleting Python objects before exit
./test-cleanup.py
```
