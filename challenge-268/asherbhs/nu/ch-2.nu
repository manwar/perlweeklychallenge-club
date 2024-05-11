def number-game [ints: list<int>] -> list<int> {
	$ints | sort | group 2 | each { reverse } | flatten
}

print (number-game [2 5 3 4])
print (number-game [9 4 1 3 6 4 6 1])
print (number-game [1 2 2 3])
