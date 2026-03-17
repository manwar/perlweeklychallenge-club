package main

import (
	"testing"
)

func TestRemoveLeadingZeros(t *testing.T) {
	tests := []struct {
		input    string
		expected string
	}{
		{"0001234", "1234"},
		{"000", "0"},
		{"0123", "123"},
		{"123", "123"},
		{"0", "0"},
	}

	for _, test := range tests {
		result := removeLeadingZeros(test.input)
		if result != test.expected {
			t.Errorf("removeLeadingZeros(%s) = %s; expected %s", test.input, result, test.expected)
		}
	}
}
