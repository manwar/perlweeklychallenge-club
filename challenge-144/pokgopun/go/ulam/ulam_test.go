package ulam

import "testing"

func TestNewUlam(t *testing.T) {
	data := []struct {
		u, v, n uint
		seq     string
	}{
		{1, 2, 0, ""},
		{2, 3, 1, "2"},
		{2, 5, 2, "2, 5"},
		{1, 2, 10, "1, 2, 3, 4, 6, 8, 11, 13, 16, 18"},
		{2, 3, 10, "2, 3, 5, 7, 8, 9, 13, 14, 18, 19"},
		{2, 5, 10, "2, 5, 7, 9, 11, 12, 13, 15, 19, 23"},
	}
	for _, d := range data {
		res := NewUlam(d.u, d.v, d.n).String()
		ans := d.seq
		if ans != res {
			t.Error("incorrect result: expected " + ans + ", got " + res)
		}
	}
}
