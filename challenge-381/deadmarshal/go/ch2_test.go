package main

import "testing"

func TestSmallerGreaterElement(t *testing.T) {
	tests := []struct {
		arr  []int
		want int
	}{
		{[]int{2, 4}, 0},
		{[]int{1, 1, 1, 1}, 0},
		{[]int{1, 1, 4, 8, 12, 12}, 2},
		{[]int{3, 6, 6, 9}, 2},
		{[]int{0, -5, 10, -2, 4}, 3},
	}
	for _, tt := range tests {
		got := smallerGreaterElement(tt.arr)
		if got != tt.want {
			t.Errorf("smallerGreaterElement(%v) = %d; want = %d", tt.arr, got, tt.want)
		}
	}
}
