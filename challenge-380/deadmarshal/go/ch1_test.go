package main

import "testing"

func TestSumOfFrequencies(t *testing.T) {
	tests := []struct {
		s    string
		want int
	}{
		{"banana", 5},
		{"teestett", 7},
		{"aeiouuaa", 3},
		{"rhythm", 2},
		{"x", 1},
	}

	for _, tt := range tests {
		got := sumOfFrequencies(tt.s)
		if got != tt.want {
			t.Errorf("sumOfFrequencies(%v) = %v; want = %v", tt.s, got, tt.want)
		}
	}
}
