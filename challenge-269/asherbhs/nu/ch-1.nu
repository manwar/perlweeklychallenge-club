def bitwise-or [ints: list<int>] -> bool {
	($ints | where { 0 == $in mod 2 } | length) >= 2
}

print (bitwise-or [1 2 3 4 5])
print (bitwise-or [2 3 8 16])
print (bitwise-or [1 2 5 7 9])
