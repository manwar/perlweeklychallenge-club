/*
Write a script to generate first 20 Brilliant Numbers.

Brilliant numbers are numbers with two prime factors of the same length.

The number should have exactly two prime factors, i.e. it’s the product of two primes of the same length.
*/
package brilliant

import (
	"log"
	"math"
	"sort"
	"strconv"
	"strings"
)

func NewBrllnt(n uint) (bn brllnt) {
	if n < 1 {
		log.Fatal("number must be greater than 0")
	}
	bn.n = int(n)
	k := 99
	for {
		bn.buildPrime(k)
		bn.pgroup = [][]int{[]int{}}
		bn.vals = []int{}
		var i, j int
		j++
		for {
			if len(strconv.Itoa(bn.plist[i])) == j {
				bn.pgroup[j-1] = append(bn.pgroup[j-1], bn.plist[i])
				i++
				if i >= len(bn.plist) {
					break
				}
			} else {
				j++
				bn.pgroup = append(bn.pgroup, []int{})
			}
		}
		for l := 0; l < j; l++ {
			for p := 0; p < len(bn.pgroup[l]); p++ {
				for q := p; q < len(bn.pgroup[l]); q++ {
					bn.vals = append(bn.vals, bn.pgroup[l][p]*bn.pgroup[l][q])
				}
			}
		}
		if len(bn.vals) >= bn.n {
			break
		}
		k = 10*k + 9
	}
	sort.SliceStable(bn.vals, func(i, j int) bool {
		return bn.vals[i] < bn.vals[j]
	})
	//fmt.Println(bn.pgroup)
	return bn
}

type brllnt struct {
	n      int
	pmap   []bool
	plist  []int
	pgroup [][]int
	vals   []int
}

func (bn brllnt) String() string {
	var b strings.Builder
	for i := 0; i < bn.n; i++ {
		b.WriteString(", " + strconv.Itoa(bn.vals[i]))
	}
	return b.String()[2:]
}

func (bn *brllnt) buildPrime(n int) {
	bn.pmap = make([]bool, int(n)+1)
	for i := 2; i <= n; i++ {
		bn.pmap[i] = true
	}
	for i := 2; float64(i) <= math.Sqrt(float64(n)); i++ {
		if !bn.pmap[i] {
			continue
		}
		j := i * i
		for j <= n {
			bn.pmap[j] = false
			j += i
		}
	}
	bn.plist = []int{}
	for i := 2; i < len(bn.pmap); i++ {
		if bn.pmap[i] {
			bn.plist = append(bn.plist, i)
		}
	}
}
