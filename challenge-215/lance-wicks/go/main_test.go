package main

import "testing"

func TestIsNotAlphaOrder(t *testing.T) {

	got := IsNotAlphaOrder("abc")
	want := false

	if got != want {
		t.Errorf("Did not return false")
	}

	got = IsNotAlphaOrder("acb")
	want = true

	if got != want {
		t.Errorf("Did not return true")
	}
}

func TestCount(t *testing.T) {

	input := []string{"abc", "xyz", "tsu"}
	got := Count(input)
	want := 1

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}

	input = []string{"rat", "cab", "dad"}
	got = Count(input)
	want = 3

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}

	input = []string{"x", "y", "z"}
	got = Count(input)
	want = 0

	if got != want {
		t.Errorf("got %d, wanted %d", got, want)
	}
}
