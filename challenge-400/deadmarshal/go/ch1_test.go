package ch1

import "testing"

func TestLargestInterval(t *testing.T) {
	tests := []struct {
		name string
		n    int
		want int
	}{
		{"Example 1", 20, 2},
		{"Example 2", 110, 4},
		{"Example 3", 500, 11},
		{"Example 4", 2026, 105},
		{"Example 5", 10000, 105},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := largestInterval(tt.n); got != tt.want {
				t.Errorf("LargestInterval(%d) = %d, want %d", tt.n, got, tt.want)
			}
		})
	}
}
