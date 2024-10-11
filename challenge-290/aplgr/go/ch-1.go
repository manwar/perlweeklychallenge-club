package main

func doubleExist(ints []int) bool {
	seen := make(map[int]bool)

	for _, num := range ints {
		if (num%2 == 0 && seen[num/2]) || seen[num*2] {
			return true
		}
		seen[num] = true
	}

	return false
}
