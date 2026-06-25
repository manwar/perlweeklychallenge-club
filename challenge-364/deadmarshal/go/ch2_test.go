package main

import "testing"

func TestGoalParser(t *testing.T) {
	tests := []struct {
		s, want string
	}{
		{"G()(al)", "Goal"},
		{"G()()()()(al)", "Gooooal"},
		{"(al)G(al)()()", "alGaloo"},
		{"()G()G", "oGoG"},
		{"(al)(al)G()()", "alalGoo"},
	}
	for _, tt := range tests {
		got := goalParser(tt.s)
		if got != tt.want {
			t.Errorf("goalParser(%s) = %s; want %s", tt.s, got, tt.want)
		}
	}
}
