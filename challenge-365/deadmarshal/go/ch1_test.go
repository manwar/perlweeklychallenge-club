package main

import "testing"

func TestAlphabetIndexDigitSum(t *testing.T) {
	tests := []struct {
		s    string
		k    int
		want int
	}{
		{"abc", 1, 6},
		{"az", 2, 9},
		{"cat", 1, 6},
		{"dog", 2, 8},
		{"perl", 3, 6},
	}

	for _, tt := range tests {
		got := alphabetIndexDigitSum(tt.s, tt.k)
		if got != tt.want {
			t.Errorf("alphabetIndexDigitSum(%s,%d) = %d; want %d", tt.s, tt.k, got, tt.want)
		}
	}
}
