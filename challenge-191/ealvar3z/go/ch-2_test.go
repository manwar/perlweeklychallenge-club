package main

import "testing"

func TestSolutionII(t *testing.T) {
	got := cute_list(2)
	want := 2

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}
