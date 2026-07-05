package main

import "testing"

func TestPrefixSuffix(t *testing.T) {
	tests := []struct {
		arr  []string
		want int
	}{
		{[]string{"a", "aba", "ababa", "aa"}, 4},
		{[]string{"pa", "papa", "ma", "mama"}, 2},
		{[]string{"abao", "ab"}, 0},
		{[]string{"abab", "abab"}, 1},
		{[]string{"ab", "abab", "ababab"}, 3},
		{[]string{"abc", "def", "ghij"}, 0},
	}
	for _, tt := range tests {
		got := prefixSuffix(tt.arr)
		if got != tt.want {
			t.Errorf("prefixSuffix(%v) = %v; want = %v", tt.arr, got, tt.want)
		}
	}
}
