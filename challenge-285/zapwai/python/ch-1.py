def proc(routes) :
	print("Input: ")
	for l in range(len(routes)):
		 print(" ",routes[l])
	inlist = []
	outlist = []
	for j in routes:
	    inlist.append(j[0])
	    outlist.append(j[1])
	
	ans = "a"
	for needle in outlist :
	    found = 0
	for hay in inlist:
		if needle == hay :
		    found = 1
		    break
	
	if found == 0 :
		ans = needle
	
	print("Output:", ans)

routes = [["B","C"], ["D","B"], ["C","A"]]
proc(routes)
routes = [["A","Z"]]
proc(routes)
