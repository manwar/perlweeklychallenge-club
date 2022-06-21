package primorial

import (
	"math/big"
)

func PrimorialNums(n uint) (s []*big.Int) {
	j := big.NewInt(1)
	var l int
	for l < int(n) {
		if j.Cmp(big.NewInt(1)) == 0 || j.ProbablyPrime(0) {
			s = append(s, new(big.Int).Set(j))
			l = len(s)
			if l > 1 {
				s[l-1].Mul(s[l-1], s[l-2])
			}
		}
		j.Add(j, big.NewInt(1))
	}
	return s
}
