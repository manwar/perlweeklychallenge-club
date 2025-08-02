package main

import (
    "testing"
)

func TestClosestPalindrome(t *testing.T) {
    testCases := [][]string{
        { "123", "121" },
        { "2", "1" },
        { "1400", "1441" },
        { "1001", "999" },
    }

    for _, tc := range testCases {
        got := closestPalindrome(tc[0])
        want := tc[1]
        if got != want {
            t.Errorf("closestPalindrome(%s) = %s; want %s", tc[0], got, want)
        }
    }
}
