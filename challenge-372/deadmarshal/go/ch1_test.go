package main

import "testing"

func TestRearrangeSpaces(t *testing.T) {
	tests := []struct {
		s    string
		want string
	}{
		{"  challenge  ", "challenge    "},
		{"coding  is  fun", "coding  is  fun"},
		{"a b c  d", "a b c d "},
		{"  team      pwc  ", "team          pwc"},
		{"   the  weekly  challenge  ", "the    weekly    challenge "},
	}
	for _, tt := range tests {
		got := rearrangeSpaces(tt.s)
		if got != tt.want {
			t.Errorf("rearrangeSpaces(%s) = %s; want = %s", tt.s, got, tt.want)
		}
	}
}
