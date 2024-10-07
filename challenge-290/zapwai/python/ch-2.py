import re
def proc(s) :
	print( "Input:", s)
	s = re.sub(r'\s+', '', s)
	digit = [int(c) for c in s]
	payload = digit.pop()
	digit.reverse()
	mysum = 0
	for i in range(len(digit)):
		if i % 2 == 0:
			x = 2*digit[i]
			if x > 9:
				a = int (x / 10)
				b = x % 10
				mysum += a + b
			else:
				mysum += x
		else:
			mysum += digit[i]
	ans = "false"
	if (mysum + payload) % 10 == 0:
		ans = "true" 
	print( "Output:", ans)

s = "17893729974"
proc(s)

s = "4137 8947 1175 5904"
proc(s)
s = "4137 8974 1175 5904"

proc(s)
