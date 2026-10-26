package ch1

import "testing"

func TestAbsentSmallestPositive(t *testing.T) {
	tests := []struct {
		name string
		in   []int
		want int
	}{
		{"Example 1", []int{1, 2, 4, 5, 6}, 7},
		{"Example 2", []int{-5, -2, -1, 3}, 1},
		{"Example 3", []int{1, 2, 3}, 4},
		{"Example 4", []int{2, 3, 7, 8}, 6},
		{"Example 5", []int{1, 1, 1, 10}, 4},
	}

	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			if got := absentSmallestPositive(tc.in); got != tc.want {
				t.Errorf("absentSmallestPositive(%v) = %d, want %d", tc.in, got, tc.want)
			}
		})
	}
}
