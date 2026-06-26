package main

import "testing"

func TestValidTokenCounter(t *testing.T) {
	tests := []struct {
		s    string
		want int
	}{
		{"cat and dog", 3},
		{"a-b c! d,e", 2},
		{"hello-world! this is fun", 4},
		{"ab- cd-ef gh- ij!", 2},
		{"wow! a-b-c nice.", 2},
	}

	for _, tt := range tests {
		got := validTokenCounter(tt.s)
		if got != tt.want {
			t.Errorf("validTokenCounter(%s) = %d; want %d", tt.s, got, tt.want)
		}
	}
}
