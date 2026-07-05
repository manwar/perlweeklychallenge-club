package main

import "testing"

func TestLargestSameDigitNumber(t *testing.T) {
	tests := []struct {
		s    string
		want int
	}{
		{"6777133339", 3333},
		{"1200034", 4},
		{"44221155", 55},
		{"88888", 88888},
		{"11122233", 222},
	}
	for _, tt := range tests {
		got := largestSameDigitNumber(tt.s)
		if got != tt.want {
			t.Errorf("largestSameDigitNumber(%s) = %d; want = %d", tt.s, got, tt.want)
		}
	}
}
