package main

import (
	"testing"
)

func TestDoubleExist(t *testing.T) {
	tests := []struct {
		input    []int
		expected bool
	}{
		{input: []int{6, 2, 3, 3}, expected: true},
		{input: []int{3, 1, 4, 13}, expected: false},
		{input: []int{2, 1, 4, 2}, expected: true},
		{input: []int{5, 10, 3, 7}, expected: true},
		{input: []int{1, 2, 4, 8}, expected: true},
		{input: []int{1, 3, 5, 7}, expected: false},
	}

	for _, test := range tests {
		result := doubleExist(test.input)
		if result != test.expected {
			t.Errorf("doubleExist(%v) = %v; expected %v", test.input, result, test.expected)
		}
	}
}
