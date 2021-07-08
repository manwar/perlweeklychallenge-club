package main

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestSwap(t *testing.T) {
	expect := 154
	got := swapBits(101)

	assert.Equal(t, expect, got, "Example 1")
}

func TestReverse(t *testing.T) {
	expect := "cba"
	got := Reverse("abc")

	assert.Equal(t, expect, got, "Reverse")
}
