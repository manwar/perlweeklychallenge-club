package main

import "testing"

func TestBigAndLittleOmega(t *testing.T) {
	tests := []struct {
		number, mode uint64
		want         int
	}{
		{100061, 0, 3},
		{971088, 0, 3},
		{63640, 1, 6},
		{988841, 1, 2},
		{211529, 0, 2},
	}
	for _, tt := range tests {
		got := bigAndLittleOmega(tt.number, tt.mode)
		if got != tt.want {
			t.Errorf("bigAndLittleOmega(%v,%v) = %v; want %v", tt.number, tt.mode, got, tt.want)
		}
	}
}
