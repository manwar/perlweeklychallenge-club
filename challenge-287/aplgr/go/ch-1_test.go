package main

import (
    "testing"
)

func TestMinimumStepsToStrongPassword(t *testing.T) {
    tests := []struct {
        password string
        expected int
    }{
        {"a", 5},
        {"aB2", 3},
        {"PaaSW0rd", 0},
        {"Paaasw0rd", 1},
        {"aaaaa", 2},
    }

    for _, test := range tests {
        result := minimumStepsToStrongPassword(test.password)
        if result != test.expected {
            t.Errorf("For password '%s', expected %d but got %d", test.password, test.expected, result)
        }
    }
}
