package main

import (
	"testing"
)

func TestSolutionII(t *testing.T) {
	cases := []struct {
		in      []float64
		out     int
		example string
	}{
		{[]float64{1, 0, 5}, 4, "example 1"},
		{[]float64{0, 2, 0}, -1, "example 2"},
		{[]float64{0, 3, 0}, 2, "example 3"},
	}
	for _, c := range cases {
		if got := equalDistro(c.in); got != c.out {
			t.Errorf("got %d, want %d, on %s", got, c.out, c.example)
		}
	}
}
