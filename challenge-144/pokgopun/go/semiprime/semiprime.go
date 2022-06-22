package semiprime

import (
	"math"
	"strconv"
)

func NewSemiprime(n uint) (smprm semiprime) {
	smprm.n = n
	smprm.buildPrime(n)
	for i := uint(2); i <= n; i++ {
		if smprm.isSemiprime(i) {
			smprm.vals = append(smprm.vals, i)
		}
	}
	return smprm
}

type semiprime struct {
	pmap  []bool
	plist []uint
	n     uint
	vals  []uint
}

func (smprm semiprime) String() (s string) {
	if len(smprm.vals) == 0 {
		return s
	}
	for _, v := range smprm.vals {
		s += ", " + strconv.FormatUint(uint64(v), 10)
	}
	return s[2:]
}

func (smprm semiprime) isSemiprime(n uint) bool {
	if smprm.pmap[n] {
		return false
	}
	for i := 0; i < len(smprm.plist); i++ {
		if n%smprm.plist[i] == 0 {
			n /= smprm.plist[i]
			break
		}
	}
	if smprm.pmap[n] {
		return true
	}
	return false
}

func (smprm *semiprime) buildPrime(n uint) {
	smprm.pmap = make([]bool, int(n)+1)
	for i := 2; i <= int(n); i++ {
		smprm.pmap[i] = true
	}
	l := int(math.Floor(math.Sqrt(float64(n))))
	for i := 2; i <= l; i++ {
		if !smprm.pmap[i] {
			continue
		}
		j := i * i
		for j <= int(n) {
			smprm.pmap[j] = false
			j += i
		}
	}
	for i := 2; i < len(smprm.pmap); i++ {
		if smprm.pmap[i] {
			smprm.plist = append(smprm.plist, uint(i))
		}
	}
}
