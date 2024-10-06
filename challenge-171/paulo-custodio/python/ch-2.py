#!/usr/bin/env python3

# Challenge 171
#
# Task 2: First-class Function
# Submitted by: Mohammad S Anwar
#
# Create sub compose($f, $g) which takes in two parameters $f and $g as
# subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x) =
# $f->($g->($x))
#
# e.g.
#
# $f = (one or more parameters function)
# $g = (one or more parameters function)
#
# $h = compose($f, $g)
# $f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...

import sys

def compose(f, g):
    return lambda x: f(g(x))

def times3(x):
    return 3 * x

def times5(x):
    return 5 * x

h = compose(times3, times5)
print(h(int(int(sys.argv[1]))))
