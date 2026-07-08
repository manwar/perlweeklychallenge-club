package main

import "testing"

func TestSameRowColumn(t *testing.T) {
	tests := []struct {
		m    [][]int
		want bool
	}{
		{[][]int{{1, 2, 3, 4},
			{2, 3, 4, 1},
			{3, 4, 1, 2},
			{4, 1, 2, 3}}, true},
		{[][]int{{1}}, true},
		{[][]int{{1, 2, 5},
			{5, 1, 2},
			{2, 5, 1}}, false},
		{[][]int{{1, 2, 3},
			{1, 2, 3},
			{1, 2, 3}}, false},
		{[][]int{{1, 2, 3},
			{3, 2, 1},
			{3, 2, 1}}, false},
	}
	for _, tt := range tests {
		got := sameRowColumn(tt.m)
		if got != tt.want {
			t.Errorf("sameRowColumn(%v) = %v; want = %v", tt.m, got, tt.want)
		}
	}
}
