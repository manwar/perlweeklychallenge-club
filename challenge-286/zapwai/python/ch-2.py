def proc(ints) :
	print("Input: ints =", ints);
	while (len(ints) > 2):
		L = []
		for i in range(int(len(ints)/2)):
			if i % 2 == 0 :
				L.append(min(ints[2*i], ints[2*i + 1]))
			else :
				L.append(max(ints[2*i], ints[2*i + 1]))
		ints = L
	print("Output:", min(ints))

ints = [2, 1, 4, 5, 6, 3, 0, 2]
proc(ints)
ints = [0, 5, 3, 2]
proc(ints)
ints = [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]
proc(ints)
