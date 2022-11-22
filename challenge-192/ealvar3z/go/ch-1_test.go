package main

import (
	"testing"
)

func TestSolution(t *testing.T) {
	cases := []struct {
		in      int
		out     int
		example string
	}{
		{5, 2, "example 1"},
		{4, 3, "example 2"},
		{6, 1, "example 3"},
	}
	for _, c := range cases {
		if got := BinaryFlip(c.in); got != c.out {
			t.Errorf("got %d, want %d, on %s", got, c.out, c.example)
		}
	}
}
