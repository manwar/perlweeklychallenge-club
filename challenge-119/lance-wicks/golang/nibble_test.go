package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSwap(t *testing.T) {

	t.Run("Example 1", func(t *testing.T) {
		got := NSwap(101)
		want := 86

		assert.Equal(t, got, want)
	})

	t.Run("Example 2", func(t *testing.T) {
		got := NSwap(18)
		want := 33

		assert.Equal(t, got, want)
	})
}
