package main

import (
	"testing"
)

func TestLargestContiguousBlock(t *testing.T) {
	tests := []struct {
		matrix [][]rune
		expected int
	}{
		{
			matrix: [][]rune{
				{'x', 'x', 'x', 'x', 'o'},
				{'x', 'o', 'o', 'o', 'o'},
				{'x', 'o', 'o', 'o', 'o'},
				{'x', 'x', 'x', 'o', 'o'},
			},
			expected: 11,
		},
		{
			matrix: [][]rune{
				{'x', 'x', 'x', 'x', 'x'},
				{'x', 'o', 'o', 'o', 'o'},
				{'x', 'x', 'x', 'x', 'o'},
				{'x', 'o', 'o', 'o', 'o'},
			},
			expected: 11,
		},
		{
			matrix: [][]rune{
				{'x', 'x', 'x', 'o', 'o'},
				{'o', 'o', 'o', 'x', 'x'},
				{'o', 'x', 'x', 'o', 'o'},
				{'o', 'o', 'o', 'x', 'x'},
			},
			expected: 7,
		},
		{
			matrix: [][]rune{},
			expected: 0,
		},
	}

	for i, test := range tests {
		result := largestContiguousBlock(test.matrix)
		if result != test.expected {
			t.Errorf("Test %d failed: expected %d, got %d", i+1, test.expected, result)
		}
	}
}
