package ch107

import "testing"

func TestIsSelfDescriptive(t *testing.T) {
	expectedMap := map[int]bool{
		1210: true,
		1211: false,
	}
	for input, expected := range expectedMap {
		res := IsSelfDescriptive(input)
		if res != expected {
			t.Errorf("IsSelfDescriptive(%d) returned '%v' but '%v' was expected",
				input, res, expected)
		}
	}
}

func TestSelfDescriptiveNumbers(t *testing.T) {
	input := 3
	expected := []int{1210, 2020, 21200}
	res := SelfDescriptiveNumbers(input)
	equals := len(expected) == len(res)
	for i := 0; i < len(res) && equals; i++ {
		equals = expected[i] == res[i]
	}
	if !equals {
		t.Errorf("SelfDescriptiveNumbers(%d) returned '%v' but '%v' was expected",
			input, res, expected)
	}
}
