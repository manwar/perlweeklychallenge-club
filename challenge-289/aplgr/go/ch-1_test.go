package main

import (
	"errors"
	"testing"
)

func TestThirdMax(t *testing.T) {
	tests := []struct {
		args []int
		exp  int
		err  error
		desc string
	}{
		{args: []int{5, 6, 4, 1}, exp: 4, err: nil, desc: "Third element"},
		{args: []int{4, 5},       exp: 5, err: nil, desc: "Last element"},
		{args: []int{1, 2, 2, 3}, exp: 1, err: nil, desc: "Third element with duplicates"},
		{args: []int{3, 3, 3},    exp: 3, err: nil, desc: "Only one value"},
		{args: []int{},           exp: 0, err: errors.New("input slice is empty"), desc: "Empty array"},
	}

	for _, test := range tests {
		got, err := thirdMax(test.args)
		if got != test.exp || (err != nil && err.Error() != test.err.Error()) {
			t.Errorf("%s: got %d, want %d, error: %v", test.desc, got, test.exp, err)
		}
	}
}