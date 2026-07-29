package main

import "testing"

func TestBaseN(t *testing.T) {
	tests := []struct {
		num, base uint
		want      string
	}{
		{42, 2, "101010"},
		{15642094, 16, "EEADEE"},
		{493, 8, "755"},
		{2228519, 36, "1BRJB"},
		{123456789, 64, "7MyqL"},
	}
	for _, tt := range tests {
		got := baseN(tt.num, tt.base)
		if got != tt.want {
			t.Errorf("baseN(%v,%v) = %v; want = %v", tt.num, tt.base, got, tt.want)
		}
	}
}
