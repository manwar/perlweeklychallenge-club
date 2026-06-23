package main

import (
	"slices"
	"testing"
)

func TestArmstrongNumber(t *testing.T) {
	tests := []struct {
		base, limit int
		want        []int
	}{
		{10, 1000, []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407}},
		{7, 1000, []int{0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250}},
		{16, 1000, []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645}},
	}
	for _, tt := range tests {
		got := isArmstrong(tt.base, tt.limit)
		if !slices.Equal(got, tt.want) {
			t.Errorf("ArmstrongNumber(%d,%d) = %v; want %v", tt.base, tt.limit, got, tt.want)
		}
	}
}
