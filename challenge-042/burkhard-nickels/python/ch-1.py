#!/usr/bin/python

import array as arr

print "ch-1.py (Version 1.0) PWC #42 Task #1: Octal numbers."

for i in range(0,50):
	print "Decimal: ", i, " - Octal: ", oct(i)


def print_string(n): 
	buf = "Decimal: %d, Octal: %o" % (n, n)
	return buf
  
a = list(range(0,50))
x = map(print_string, a) 
# print(list(x)) 
for e in x: print e

