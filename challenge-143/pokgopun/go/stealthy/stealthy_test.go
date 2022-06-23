package stealthy

import "testing"

func TestIsStealthy(t *testing.T) {
	m := map[uint]bool{
		36: true,
		12: true,
		6:  false,
	}
	for n, ans := range m {
		res := IsStealthy(n)
		if res != ans {
			t.Errorf("incorrect result for %d: expected %t, got %t", n, ans, res)
		}
	}
}
