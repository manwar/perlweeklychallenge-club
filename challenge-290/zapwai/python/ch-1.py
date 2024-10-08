def proc(ints) :
	print( "Input: ints = [", ints)
	ans = "false"
	for i in range(len(ints)-1):
	    for j in range(i + 1, len(ints)) :
		    if ints[i] == 2 * ints[j] or ints[j] == 2 * ints[i] :
		        ans = "true"
	print( "Output:", ans)

ints = [6, 2, 3, 3]
proc(ints)
ints = [3, 1, 4, 13]
proc(ints)
ints = [2, 1, 4, 2]
proc(ints)
