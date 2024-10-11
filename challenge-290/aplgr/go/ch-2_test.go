package main

import (
	"testing"
)

func TestLuhnCheck(t *testing.T) {
	tests := []struct {
		input    string
		expected bool
	}{
		{input: "17893729974", expected: true},
		{input: "4137 8947 1175 5904", expected: true},
		{input: "4137 8974 1175 5904", expected: false},
		{input: "1234 5678 9012 3456", expected: false},
		{input: "79927398713", expected: true},
		{input: "1234567890", expected: false},
		{input: "", expected: false},
		{input: "abcdefg", expected: false},
	}

	for _, test := range tests {
		result := luhnCheck(test.input)
		if result != test.expected {
			t.Errorf("luhnCheck(%q) = %v; expected %v", test.input, result, test.expected)
		}
	}
}
