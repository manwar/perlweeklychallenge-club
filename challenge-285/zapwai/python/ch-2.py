def tally(p, n, d, q, h) :
	return p + 5*n + 10*d + 25*q + 50*h 
amt = 100
cnt = 0
for h in range(1 + (int) (amt/50)) :
	for q in range(1 + (int) (amt/25)) :
		for d in range(1 + (int) (amt/10)) :
			for n in range(1 + (int) (amt/5)) :
				for p in range(1 + amt) :
					if tally(p, n, d, q, h) == amt :
						cnt += 1

print("There are", cnt, "ways to make change for", amt, "cents.")
