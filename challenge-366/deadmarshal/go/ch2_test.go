package main

import "testing"

func TestValidTimes(t *testing.T) {
	tests := []struct {
		s    string
		want int
	}{
		{"?2:34", 3},
		{"?4:?0", 12},
		{"??:??", 1440},
		{"?3:45", 3},
		{"2?:15", 4},
	}

	for _, tt := range tests {
		got := validTimes(tt.s)
		if got != tt.want {
			t.Errorf("validTimes(%s) = %d; want %d", tt.s, got, tt.want)
		}
	}
}
