package main

func DivisiblePairs(l []int, k int) int {
	var count int
	size := len(l)
	for i := 0; i < size; i++ {
		for j := i + 1; j < size; j++ {
			if (l[i]+l[j])%k == 0 {
				count++
			}
		}
	}
	return count
}
