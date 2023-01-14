package main

import "fmt"

func main() {
	tests := [][]int{
		{1, 2, 3, 1, 1, 3},
		{1, 2, 3},
		{1, 1, 1, 1},
	}
	for i := range tests {
		fmt.Println("Output: ", solve(tests[i]))
	}
}

// Given a list of ints:
// we're asked to find the total count of "Good Pairs"
//	A pair(i,j) is good iff list[i] == list[j] && i < j

// we'll keep a counter of the times we have the value
// in our counter map by looping over each value in the array
func solve(list []int) int {
	total := 0
	counter := make(map[int]int)
	for _, j := range list {
		total += counter[j]
		counter[j]++
	}
	return total
}
