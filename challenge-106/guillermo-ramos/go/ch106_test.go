package ch106

import "testing"

type MaxGapCase struct {
	input []int
	wants int
}

func TestMaximumGap(t *testing.T) {
	expected := []MaxGapCase{
		{[]int{2, 9, 3, 5}, 4},
		{[]int{1, 3, 8, 2, 0}, 5},
		{[]int{5}, 0},
	}
	for _, c := range expected {
		res := MaximumGap(c.input)
		if res != c.wants {
			t.Errorf("MaximumGap(%v) returned '%d' but expected '%d'",
				c.input, res, c.wants)
		}
	}
}

type DecStringInput struct {
	n, d int
}

func TestDecimalString(t *testing.T) {
	expected := map[DecStringInput]string{
		{n: 1, d: 3}:  "0.(3)",
		{n: 1, d: 2}:  "0.5",
		{n: 5, d: 66}: "0.0(75)",
	}
	for input, wants := range expected {
		res := DecimalString(input.n, input.d)
		if res != wants {
			t.Errorf("DecimalString(%d, %d) returned '%s' but expected '%s'",
				input.n, input.d, res, wants)
		}
	}
}
