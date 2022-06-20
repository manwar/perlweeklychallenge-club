/*
The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)

A Perrin prime is a number in the Perrin sequence which is also a prime number.

Calculate the first 13 Perrin Primes.

f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]
*/
package perrinprime

import (
	"log"
	"math/big"
	"sort"
	"strconv"
)

type perrinPrime struct {
	big.Int
	base [3]uint
	vals []uint
}

func NewPerrinPrime(n int) (pp perrinPrime) {
	if n < 1 {
		log.Fatal("must be greater than 1")
	}
	pp.base = [3]uint{3, 0, 2}
	vals := map[uint]struct{}{}
	for i := 0; i < 1_000_000 && len(vals) < n; i++ {
		if pp.SetInt64(int64(pp.base[0])).ProbablyPrime(0) {
			vals[pp.base[0]] = struct{}{}
		}
		pp.base = [3]uint{pp.base[1], pp.base[2], pp.base[0] + pp.base[1]}
	}
	for k := range vals {
		pp.vals = append(pp.vals, k)
	}
	sort.SliceStable(pp.vals, func(i, j int) bool {
		return pp.vals[i] < pp.vals[j]
	})
	return pp
}
func (pp perrinPrime) String() string {
	var str string
	for _, v := range pp.vals {
		str += ", " + strconv.FormatUint(uint64(v), 10)
	}
	return str[2:]
}
