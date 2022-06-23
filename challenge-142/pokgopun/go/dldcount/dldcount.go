package dldcount

import (
	"math"
)

func Count(m, n uint) (c uint) {
	lim := uint(math.Floor(math.Sqrt(float64(m))))
	if n == 1 {
		c++
	}
	for d := uint(2); d <= lim; d++ {
		if m%d == 0 {
			for _, v := range []uint{d, m / d} {
				if v%10 == n {
					c++
				}
			}
		}
	}
	return c
}
