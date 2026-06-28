package main

import "testing"

func TestCountPrefixes(t *testing.T) {
	tests := []struct {
		arr  []string
		str  string
		want uint
	}{
		{[]string{"a", "ap", "app", "apple", "banana"}, "apple", 4},
		{[]string{"cat", "dog", "fish"}, "bird", 0},
		{[]string{"hello", "he", "hell", "heaven", "he"}, "hello", 4},
		{[]string{"", "code", "coding", "cod"}, "coding", 3},
		{[]string{"p", "pr", "pro", "prog", "progr", "progra", "program"}, "program", 7},
	}
	for _, tt := range tests {
		got := countPrefixes(tt.arr, tt.str)
		if got != tt.want {
			t.Errorf("countprefixes(%v,%s) = %d; want %d", tt.arr, tt.str, got, tt.want)
		}
	}
}
