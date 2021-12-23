#!/usr/bin/python3

# Challenge 029

# Task #2
# Write a script to demonstrate calling a C function. It could be any user
# defined or standard C function.

import sys
import ctypes
import pathlib

# Load the shared library into ctypes
libname = pathlib.Path().absolute() / "libcmult.so"
c_lib = ctypes.CDLL(libname)
c_lib.cmult.restype = ctypes.c_float

x = int(sys.argv[1])
y = float(sys.argv[2])
result = c_lib.cmult(x, ctypes.c_float(y))
print(f"{result:.2f}")
