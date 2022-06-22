package ulam

import (
	"sort"
	"strconv"
)

type ulam struct {
	u, v, n uint
	vals    []uint
}

func (ul ulam) String() (s string) {
	if ul.n == 0 {
		return s
	}
	for _, v := range ul.vals {
		s += ", " + strconv.FormatUint(uint64(v), 10)
	}
	return s[2:]
}

func NewUlam(u, v, n uint) ulam {
	ul := ulam{u, v, n, []uint{u, v, u + v}}
	if n < 3 {
		ul.vals = ul.vals[:int(n)]
		return ul
	}
	for len(ul.vals) < int(n) {
		m := make(map[uint]uint)
		l := len(ul.vals)
		var sum uint
		for i := 0; i < l; i++ {
			for j := i + 1; j < l; j++ {
				sum = ul.vals[i] + ul.vals[j]
				if sum > ul.vals[l-1] {
					m[sum]++
				}
			}
		}
		var s []uint
		for k, v := range m {
			if v > 1 {
				continue
			}
			s = append(s, k)
		}
		sort.SliceStable(s, func(i, j int) bool {
			return s[i] < s[j]
		})
		ul.vals = append(ul.vals, s[0])
	}
	return ul
}
