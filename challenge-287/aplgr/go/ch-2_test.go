package main

import (
    "testing"
)

func TestIsValidNumber(t *testing.T) {
    testCases := []struct {
        input    string
        expected bool
    }{
        {"1", true},
        {"a", false},
        {".", false},
        {"1.2e4.2", false},
        {"-1.", true},
        {"+1E-8", true},
        {".44", true},
    }

    for _, tc := range testCases {
        result := isValidNumber(tc.input)
        if result != tc.expected {
            t.Errorf("isValidNumber(%q) = %v; expected %v", tc.input, result, tc.expected)
        }
    }
}
