def is_pal(s) :
	r = str(s)[::-1]
	return (str(s) == r)

def proc(s) :
	print("Input:", s)
	n = int(s)
	found = False
	step = 1
	while not found :
		m = n - step
		if is_pal(m) :
			found = True
			n = m
		else :
			m = n + step
			if is_pal(m) :
				found = True
				n = m
		step += 1
	print("Output:", n)

s = "123"
proc(s)
s = "2"
proc(s)
s = "1400"
proc(s)

