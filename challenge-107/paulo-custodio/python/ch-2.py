#!/usr/bin/env python3

# Challenge 107
#
# TASK #2 - List Methods
# Submitted by: Mohammad S Anwar
# Write a script to list methods of a package/class.
#
# Example
# package Calc;
#
# use strict;
# use warnings;
#
# sub new { bless {}, shift; }
# sub add { }
# sub mul { }
# sub div { }
#
# 1;
# Output
# BEGIN
# mul
# div
# new
# add

class Calc():
    def __init__(self):
        pass
    def new(self):
        pass
    def add(self):
        pass
    def mul(self):
        pass
    def div(self):
        pass

method_list = sorted([func for func in dir(Calc) \
                if callable(getattr(Calc, func)) and not func.startswith("__")])
for func in method_list:
    print(func)
