package ch106

import "sort"

func MaximumGap(numbers sort.IntSlice) int {
	sort.Sort(numbers)
	var maxGap int
	for i := 0; i < len(numbers)-1; i++ {
		diff := numbers[i+1] - numbers[i]
		if diff > maxGap {
			maxGap = diff
		}
	}
	return maxGap
}
