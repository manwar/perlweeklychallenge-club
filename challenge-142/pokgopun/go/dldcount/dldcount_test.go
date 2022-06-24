package dldcount

import "testing"

func TestDldCount(t *testing.T) {
	data := []struct {
		m, n, o uint
	}{
		{24, 2, 2},
		{24, 1, 1},
		{24, 3, 1},
		{30, 5, 2},
		{30, 0, 1},
		{30, 6, 1},
	}
	for _, d := range data {
		res := Count(d.m, d.n)
		if res != d.o {
			t.Errorf("incorrect result: expected %d, got %d", d.o, res)
		}
	}
}
