Expectation
------------
Python3, PyQt, SIP, Qt5 are available

Building
---------
```
qmake-qt5
make
make install
```

Testing
--------
```
export PYTHONPATH=./install/lib
export LD_LIBRARY_PATH=./install/lib:$LD_LIBRARY_PATH

# test.py should crash on exit
./test.py

# test-cleanup.py should NOT crash on exit
# we are deleting Python objects before exit
./test-cleanup.py
```
