package main

import (
	"slices"
	"testing"
)

func TestSpecialBinarySubstrings(t *testing.T) {
	tests := []struct {
		s    string
		want []string
	}{
		{"0101", []string{"01", "10", "01"}},
		{"000111", []string{"000111", "0011", "01"}},
		{"000011", []string{"0011", "01"}},
		{"10011100", []string{"10", "0011", "01", "1100", "10"}},
		{"00000", []string{}},
	}
	for _, tt := range tests {
		got := specialBinarySubstrings(tt.s)
		if !slices.Equal(got, tt.want) {
			t.Errorf("specialBinarySubstrings(%v) = %v; want = %v", tt.s, got, tt.want)
		}
	}
}
