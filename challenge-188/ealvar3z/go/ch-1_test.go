package main

import (
	"testing"
)

type list struct {
	values []int
	k      int
	output int
}

var tests = []list{
	{[]int{4, 5, 1, 6}, 2, 2},
	{[]int{1, 2, 3, 4}, 2, 2},
	{[]int{1, 3, 4, 5}, 3, 2},
	{[]int{5, 1, 2, 3}, 4, 2},
	{[]int{7, 2, 4, 5}, 4, 1},
}

func TestDivisiblePairs(t *testing.T) {
	for _, p := range tests {
		v := DivisiblePairs(p.values, p.k)
		if v != p.output {
			t.Error(
				"For", p.values,
				"expected", p.output,
				"got", v,
			)
		}
	}
}
