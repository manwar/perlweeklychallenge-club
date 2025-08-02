import re
def proc(mystr) :
	print( "Input:", mystr)
	mylen = len( mystr )
	len_diff = 0
	if mylen < 6:
		len_diff = 6 - mylen
	elif mylen > 20:
		len_diff = mylen - 20
	l = list(mystr)
	lengths = []
	hits = 0
	for i in range(mylen - 1):
	    if l[i] == l[i+1]:
		    hits += 1
	    else :
		    if hits > 1 :
			    lengths.append(1+hits)
		    hits = 0
	if hits > 1 :
		lengths.append(1+hits)
	steps = 0
	for l in lengths :
		steps += int(l/3)
	lflag = 1
	uflag = 1
	dflag = 1
	if re.search('[a-z]',mystr):
		lflag = 0
	if re.search('[A-Z]',mystr):
		uflag = 0 
	if re.search('\d',mystr):
		dflag = 0 
	tally = lflag + uflag + dflag
	out_val = len_diff + steps
	if out_val < tally :
		out_val += tally - out_val
	print( "Output: ", out_val)

mystr = "a"
proc(mystr)
mystr = "aB2"
proc(mystr)
mystr = "PaaSW0rd"
proc(mystr)
mystr = "turbbbbot"
proc(mystr)
mystr  = "111"
proc(mystr)
