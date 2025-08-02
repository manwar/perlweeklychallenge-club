def proc(ints) :
	print( "Input:", ints)
	ans = max(ints)
	new1 = []
	for i in range(len(ints)):
		if ints[i] != ans:
			new1.append(ints[i])
	if len(new1) > 0 :
		m2 = max(new1)
		new2 = []
		for i in range(len(new1)):
			if new1[i] != m2:
				new2.append(new1[i])
	
		if len(new2) > 0:
			ans = max(new2)
	print( "Output:", ans)

ints = [5, 6, 4, 1]
proc(ints)
ints = [4, 5]
proc(ints)
ints = [1, 2, 2, 3]
proc(ints)

