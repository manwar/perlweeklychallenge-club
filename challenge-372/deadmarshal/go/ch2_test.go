package main

import "testing"

func TestLargestSubstring(t *testing.T) {
	tests := []struct {
		s    string
		want int
	}{
		{"aaaaa", 3},
		{"abcdeba", 5},
		{"abbc", 0},
		{"abcaacbc", 4},
		{"laptop", 2},
	}
	for _, tt := range tests {
		got := largestSubstring(tt.s)
		if got != tt.want {
			t.Errorf("largestSubstring(%s) = %d; want = %d", tt.s, got, tt.want)
		}
	}
}
