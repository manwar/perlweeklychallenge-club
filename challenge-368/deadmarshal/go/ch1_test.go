package main

import "testing"

func TestMakeItBigger(t *testing.T) {
	tests := []struct {
		s    string
		c    byte
		want string
	}{
		{"15456", '5', "1546"},
		{"7332", '3', "732"},
		{"2231", '2', "231"},
		{"543251", '5', "54321"},
		{"1921", '1', "921"},
	}
	for _, tt := range tests {
		got := makeItBigger(tt.s, tt.c)
		if got != tt.want {
			t.Errorf("makeItBigger(%v,%v) = %v; want %v", tt.s, tt.c, got, tt.want)
		}
	}
}
