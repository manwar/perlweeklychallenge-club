package ch1

import "testing"

func TestDivisibleAverage(t *testing.T) {
	tests := []struct {
		arr  []int
		want int
	}{
		{[]int{18, 5, 7, 11}, 18},
		{[]int{6, 12, 18, 24, 30, 40}, 18},
		{[]int{3, 9, 15, 21, 27}, 0},
		{[]int{6, 12, 14, 20}, 9},
		{[]int{6, 6, 6, 12, 12}, 8},
	}

	for _, tt := range tests {
		got := divisibleAverage(tt.arr)
		if got != tt.want {
			t.Errorf("divisibleAverage(%v) = %v; want = %v", tt.arr, got, tt.want)
		}
	}
}
