#!/usr/bin/env python

integers = [ 101, 18 ]

for i in integers:
	octet = (format(i, '08b'))
	nib1 = octet[0:4]
	nib2 = octet[4:]
	print(int(nib2+nib1, 2))
