package main

import "testing"

func TestNearestRGB(t *testing.T) {
	tests := []struct {
		s    string
		want string
	}{
		{"#F4B2D1", "#FF99CC"},
		{"#15E6E5", "#00FFCC"},
		{"#191A65", "#003366"},
		{"#2D5A1B", "#336633"},
		{"#00FF66", "#00FF66"},
	}
	for _, tt := range tests {
		got := nearestRGB(tt.s)
		if got != tt.want {
			t.Errorf("nearestRGB(%s) = %s; want = %s", tt.s, got, tt.want)
		}
	}
}
