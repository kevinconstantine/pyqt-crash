#!/usr/bin/env python3

from mylib import mylib

print("Creating DGraph")
dg = mylib.DGraph()
print("Creating Array")
arr = mylib.Array()
print("AddArray")
dg.AddArray(arr)
print("Delete Array")
del(arr)
print("Delete DGraph")
del(dg)
print("test.py: exiting");
