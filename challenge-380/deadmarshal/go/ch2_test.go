package main

import "testing"

func TestReverseDegree(t *testing.T) {
	tests := []struct {
		s    string
		want int
	}{
		{"z", 1},
		{"a", 26},
		{"bbc", 147},
		{"racecar", 560},
		{"zyx", 14},
	}
	for _, tt := range tests {
		got := reverseDegree(tt.s)
		if got != tt.want {
			t.Errorf("reverseDegree(%v) = %v; want = %v", tt.s, got, tt.want)
		}
	}
}
