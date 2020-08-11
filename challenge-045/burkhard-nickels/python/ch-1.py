#!/usr/bin/python

import sys
import re
import array as arr

print "ch-1.py - PWC #45 Task #1: Square Secret Code."

# ----------------------------------
msg = "The quick brown fox jumps over the lazy dog"

if len(sys.argv) > 1:
	msg = sys.argv[1]

print "Original: ", msg

msg = re.sub('\s','',msg)
msg = msg.lower()
l = list(msg)
# print "Original: ", msg
# print "Letters : ", l

coded_msg = ""
for i in range(0,8):
	# print
	# print i, ":",
	j = i
	e = len(l)
	while j < e:
		# print "(",j,"/",e,") ", l[j], " ",
		coded_msg += l[j]
		j += 8

	coded_msg += " "

print "Coded   : ", coded_msg

