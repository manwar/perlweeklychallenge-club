// Solution of Task 1 of The Weekly Challenge 263
// https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

/*
	$ go run ch-1.go
	[1 2]
	[]
	[4]
*/

package main

import (
	"fmt"
	"sort"
)

func main() {
	tests := [][]int{
		{1, 5, 3, 2, 4, 2},
		{1, 2, 4, 3, 5},
		{5, 3, 2, 4, 2, 1},
	}
	values := []int{2, 6, 4}

	for t, test := range tests {
		sort.Ints(test)
		var indices []int
		for i, n := range test {
			if n == values[t] {
				indices = append(indices, i)
			}
		}
		fmt.Println(indices)
	}
}
