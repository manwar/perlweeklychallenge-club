package ch2

import (
	"slices"
	"testing"
)

func TestBinaryReflection(t *testing.T) {
	tests := []struct {
		name string
		in   []int
		want []int
	}{
		{"Example 1", []int{3, 6, 12}, []int{3, 6, 12}},
		{"Example 2", []int{1, 2, 4, 8}, []int{1, 2, 4, 8}},
		{"Example 3", []int{7, 8, 9, 10}, []int{8, 10, 7, 9}},
		{"Example 4", []int{5, 9, 15, 17}, []int{5, 9, 15, 17}},
		{"Example 5", []int{11, 13, 14, 19}, []int{14, 13, 11, 19}},
	}

	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			got := binaryReflection(tc.in)
			if !slices.Equal(got, tc.want) {
				t.Errorf("binaryReflection(%v) = %v, want %v", tc.in, got, tc.want)
			}
		})
	}
}
