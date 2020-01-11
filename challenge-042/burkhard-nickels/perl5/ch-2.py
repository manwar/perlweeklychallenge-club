#!/usr/bin/python

import array as arr
import re
import random

print "ch-2.pl (Version 1.0) PWC #42 Task #2: Balanced Brackets\n";

def create_brackets(nr):
	s = ""
	for i in range(1,nr):
		br = random.randint(0,1)
		if br: s += ")"
		else : s += "("
	return s

def balanced_brackets(brs):
	brs, found = re.subn('\(\)','',brs);
	ok = 0
	if found:
		ok = balanced_brackets(brs)
		return ok
	else:
		if re.search('\(|\)',brs): return 0
		else: return 1

loops = 0
while True:
	loops = loops + 1
	nr  = random.randint(2,10)
	brs = create_brackets(nr)
	ok  = balanced_brackets(brs)
	rs  = "NOT OK"
	if ok: rs  = "OK" 
	print("(%2d) %10s = %s" % (loops, brs, rs))
	if ok: break
	if loops > 20: break

