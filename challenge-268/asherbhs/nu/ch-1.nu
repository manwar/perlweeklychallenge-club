def magic-number [x: list<int>, y: list<int>] -> int {
	($y | math min) - ($x | math min)
}

print (magic-number [3 7 5] [9 5 7])
print (magic-number [1 2 1] [5 4 4])
print (magic-number [2]     [5])
