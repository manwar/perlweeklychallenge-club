package stealthy

import (
	"math"
)

func IsStealthy(n uint) bool {
	lim := uint(math.Floor(math.Sqrt(float64(n))))
	prev := n + 1
	var sum uint
	for d := uint(2); d <= lim; d++ {
		if n%d == 0 {
			sum = d + n/d
			//fmt.Println("n=", n, "prev=", prev, "sum=", sum)
			if prev-sum == 1 {
				return true
			}
			prev = sum
		}
	}
	return false
}
