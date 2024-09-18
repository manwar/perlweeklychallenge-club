import re
def proc(mystr) :
	print("Input:", mystr)
	output = "False"
	p = mystr.split(".")
	if len(p) == 1 :
		if re.search('^\d+$', mystr):
			output = "True"
		elif re.search('^\d+e\d+$|^\d+E\d+$', mystr):
			output = "True"
	elif len(p) == 2:
		if re.search('^\d+$', p[0]) and re.search('^\d+$', p[1]):
			output = "True"
		elif re.search('^\d+$', p[0]) and re.search('^\d+e\d+$|^\d+E\d+$', p[1]):
			output = "True"
	
	print("Output:", output)

mystr = "1"
proc(mystr)
mystr = "56e10"
proc(mystr)
mystr = "2E32"
proc(mystr)
mystr = "a"
proc(mystr)
mystr = "1.2"
proc(mystr)
mystr = "1.2.6"
proc(mystr)
mystr = "3.142e10"
proc(mystr)
mystr = "3.142e42B"
proc(mystr)

