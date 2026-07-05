package main

import "testing"

func TestReverseExistence(t *testing.T) {
	tests := []struct {
		s    string
		want bool
	}{
		{"abcba", true},
		{"racecar", true},
		{"abcd", false},
		{"banana", true},
		{"hello", true},
	}
	for _, tt := range tests {
		got := reverseExistence(tt.s)
		if got != tt.want {
			t.Errorf("reverseExistence(%s) = %v; want = %v", tt.s, got, tt.want)
		}
	}
}
