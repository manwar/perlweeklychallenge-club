package ch106

import (
	"fmt"
	"strconv"
)

type PerioDec struct {
	digits      []int
	periodicIdx int
}

func (d PerioDec) String() (s string) {
	for i, v := range d.digits {
		if i == 1 {
			s = fmt.Sprint(s, ".")
		}
		if i == d.periodicIdx {
			s = fmt.Sprint(s, "(")
		}
		s = fmt.Sprint(s, strconv.Itoa(v))
	}
	if d.periodicIdx != -1 {
		s = fmt.Sprint(s, ")")
	}
	return
}

func DecimalString(n, d int) string {
	dec := PerioDec{periodicIdx: -1}
	numeratorIdxs := make(map[int]int)

	maxDecimals := 20
	for i := 0; i <= maxDecimals; i++ {
		if idx, ok := numeratorIdxs[n]; ok && idx > 0 {
			dec.periodicIdx = idx
			break
		}

		q := 0
		r := n
		for r >= d {
			r = r - d
			q++
		}

		numeratorIdxs[n] = i
		dec.digits = append(dec.digits, q)

		n = r * 10

		if r == 0 {
			break
		}

	}

	return dec.String()
}
