package main

import "testing"

func TestSimilarList(t *testing.T) {
	tests := []struct {
		l1, l2 []string
		l3     [][]string
		want   bool
	}{
		{[]string{"great", "acting"}, []string{"fine", "drama"}, [][]string{[]string{"great", "fine"}, []string{"acting", "drama"}}, true},
		{[]string{"apple", "pie"}, []string{"banana", "pie"},
			[][]string{[]string{"apple", "peach"}, []string{"peach", "banana"}}, false},
		{[]string{"perl4", "python"}, []string{"raku", "python"},
			[][]string{[]string{"perl4", "perl5", "raku"}}, true},
		{[]string{"enjoy", "challenge"}, []string{"love", "weekly", "challenge"},
			[][]string{[]string{"enjoy", "love"}}, false},
		{[]string{"fast", "car"},
			[]string{"quick", "vehicle"},
			[][]string{[]string{"quick", "fast"}, []string{"vehicle", "car"}}, true},
	}
	for _, tt := range tests {
		got := similarList(tt.l1, tt.l2, tt.l3)
		if got != tt.want {
			t.Errorf("similarList(%v,%v,%v) = %v; want = %v", tt.l1, tt.l2, tt.l3, got, tt.want)
		}
	}
}
