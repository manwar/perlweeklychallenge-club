import random

def jumble(word) :
	if len(word) < 4:
		return word 
	let = list(word)
	start = let[0]
	end = let[len(let) - 1]
	let = let[1:-1]
	order = []
	while (len(order) < len(let)) :
		x = random.randint(0, len(let) - 1)
		if x not in order:
			order.append(x)
	middle = ""			   
	for i in order:
		middle += let[i] 
	q = start + middle + end
	return q

def proc(s) :
	print( "Input:", s)
	words = s.split(" ")
	new = ' '.join(map(jumble, words))
	print( "Output:", new)

s = "This supposed Cambridge research is unfortunately an urban legend"
proc(s)
