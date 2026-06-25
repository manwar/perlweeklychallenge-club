package main

import "testing"

func TestDecryptString(t *testing.T) {
	tests := []struct {
		s, want string
	}{
		{"10#11#12", "jkab"},
		{"1326#", "acz"},
		{"25#24#123", "yxabc"},
		{"20#5", "te"},
		{"1910#26#", "aijz"},
	}
	for _, tt := range tests {
		got := decryptString(tt.s)
		if got != tt.want {
			t.Errorf("decryptString(%s) = %s; want %s", tt.s, got, tt.want)
		}
	}
}
