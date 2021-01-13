#!/usr/bin/env python3

numbers = [ 2, 4, 3 ]

print("numbers", numbers)

n = sorted(numbers)

pair = [ (n[i], n[j]) for i in range(len(n)) 
                      for j in range(i, len(n)) if n[i] is not n[j] ]		

bit_sum = 0

for i, j in pair:
	bin_i = "{0:032b}".format(i)
	bin_j = "{0:032b}".format(j)
	diff = 0
	for k in range(len(bin_i)):
		if bin_i[k] is not bin_j[k]: diff += 1
	
	bit_sum += diff
	print("{1} = {0}\n{3} = {2}\nf({0}, {2}) = {4}\n".format(i, bin_i, j, bin_j, diff))
	
print("bit sum = {}".format(bit_sum));
