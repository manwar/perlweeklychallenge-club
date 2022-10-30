package main

import "testing"

type testpair struct {
	x, y   int
	answer int
}

var test = []testpair{
	{5, 4, 5},
	{4, 6, 3},
	{2, 5, 4},
	{3, 1, 3},
	{7, 4, 5},
}

func TestSolution(t *testing.T) {
	for _, i := range test {
		v := Solution(i.x, i.y)
		if v != i.answer {
			t.Error(
				"For", i.x, i.y,
				"expected", i.answer,
				"got", v,
			)
		}
	}
}
