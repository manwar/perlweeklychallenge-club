package main

import (
	"testing"
)

func TestSolution(t *testing.T) {
	cases := []struct {
		in      []int
		out     int
		example string
	}{
		{[]int{1, 2, 3, 4}, -1, "example 1"},
		{[]int{1, 2, 0, 5}, 1, "example 2"},
		{[]int{2, 6, 3, 1}, 1, "example 3"},
		{[]int{4, 5, 3, 2}, -1, "example 4"},
	}
	for _, c := range cases {
		if got := Twice_largest(c.in); got != c.out {
			t.Errorf("got %d, want %d, on %s", got, c.out, c.example)
		}
	}
}
