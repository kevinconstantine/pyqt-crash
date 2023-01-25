Expectation
------------
Python3 is available
Qt5 is available

Setting up Environment
---------
```
python -m venv /tmp/venv
source /tmp/venv/bin/activate
pip install sip
pip install PyQt5-sip
pip install PyQt-builder
pip install --upgrade pip
pip install PyQt5
```

Building Reproducer
--------
```
source /tmp/venv/bin/activate
qmake
make install
```

Testing
--------
```
source /tmp/venv/bin/activate
export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib:$LD_LIBRARY_PATH

# test.py should crash on exit
./test.py

# test-cleanup.py should NOT crash on exit
# we are deleting Python objects before exit
./test-cleanup.py
```
