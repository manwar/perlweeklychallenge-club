package main

import "testing"

func TestReverseString(t *testing.T) {
	tests := []struct {
		s, want string
	}{
		{"", ""},
		{"reverse the given string", "gnirts nevig eht esrever"},
		{"Perl is Awesome", "emosewA si lreP"},
		{"v1.0.0-Beta!", "!ateB-0.0.1v"},
		{"racecar", "racecar"},
	}
	for _, tt := range tests {
		got := reverseString(tt.s)
		if got != tt.want {
			t.Errorf("reverseString(%s) = %s; want %s", tt.s, got, tt.want)
		}
	}
}
