#!/usr/bin/python

import array as arr

print "ch-1.py (Version 1.0) PWC #40 Task #1: Show multiple arrays content."

a1 = ['I','L','O','V','E','Y','O','U']
a2 = ['2','4','0','3','2','0','1','9']
a3 = ['!','?',u"\xA3",'$','%','^','&','*']
A1 = arr.array('c', a1)

for i in range(0,len(a1)):
	print A1[i], " ", a2[i], " ", a3[i]

