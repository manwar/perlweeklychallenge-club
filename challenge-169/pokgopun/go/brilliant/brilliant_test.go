package brilliant

import "testing"

func TestNewBrllnt(t *testing.T) {
	res := NewBrllnt(20).String()
	ans := "4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299"
	if res != ans {
		t.Error("incorrect result: expected " + ans + ", got " + res)
	}
}
