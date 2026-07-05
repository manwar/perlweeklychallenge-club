package main

import (
	"slices"
	"testing"
)

func TestCountVowel(t *testing.T) {
	tests := []struct {
		s    string
		want []string
	}{
		{"aeiou", []string{"aeiou"}},
		{"aaeeeiioouu", []string{"aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"}},
		{"aeiouuaxaeiou", []string{"aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou"}},
		{"uaeiou", []string{"uaeio", "uaeiou", "aeiou"}},
		{"aeioaeioa", []string{}},
	}
	for _, tt := range tests {
		got := countVowel(tt.s)
		if !slices.Equal(got, tt.want) {
			t.Errorf("countVowel(%s) = %v; want = %v", tt.s, got, tt.want)
		}
	}
}
