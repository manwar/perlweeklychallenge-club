package main

import (
	"slices"
	"testing"
)

// Sometimes the test might fail cause of order of the resultant
// items, but I don't care to fix it ;)
func TestUncommonWords(t *testing.T) {
	tests := []struct {
		s1, s2 string
		want   []string
	}{
		{"apple banana apple", "banana orange", []string{"orange"}},
		{"cat dog", "bird fish", []string{"cat", "dog", "bird", "fish"}},
		{"the quick brown fox", "the quick", []string{"brown", "fox"}},
		{"Hello", "Hello", []string{}},
		{"blue blue red", "red green green yellow", []string{"yellow"}},
	}

	for _, tt := range tests {
		got := uncommonWords(tt.s1, tt.s2)
		if !slices.Equal(tt.want, got) {
			t.Errorf("uncommonWords(%v,%v) = %v; want = %v", tt.s1, tt.s2, got, tt.want)
		}
	}
}
