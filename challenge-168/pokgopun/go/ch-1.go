package main

import (
	"fmt"
	"math/big"
	"os"
	"sort"
)

func main() {
	l := 13
	if len(os.Args) > 1 {
		fmt.Sscanf(os.Args[1], "%d", &l)
	}
	p := [3]uint{3, 0, 2}
	pp := map[uint]struct{}{}
	e := 0.25
	i, n := 0, 1
	for len(pp) < l && i < 1_000_000 {
		i++
		for float64(e) > 1/float64(p[0]) {
			e *= 0.25
			n++
		}
		//fmt.Printf("p0=%v,n=%v\n", p[0], n)
		if big.NewInt(int64(p[0])).ProbablyPrime(n) {
			pp[p[0]] = struct{}{}
		}
		p = [3]uint{p[1], p[2], p[0] + p[1]}
	}
	ppl := make([]uint, len(pp))
	var j int
	for k := range pp {
		ppl[j] = k
		j++
	}
	sort.SliceStable(ppl, func(i, j int) bool {
		return ppl[i] < ppl[j]
	})
	fmt.Println(ppl)
	//fmt.Println(len(pp))
}
