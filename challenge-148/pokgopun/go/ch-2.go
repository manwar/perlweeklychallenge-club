// From https://math.stackexchange.com/questions/1885095/parametrization-of-cardano-triplet
// a = 3k + 2
// b^2 * c = (k+1)^2 * (8k + 5)
package main

import (
	"fmt"
	"math"
	"sort"
	"strings"
)

func main() {
	cdn := newCdn3(400)
	fmt.Println(cdn)
}

func pmap(n uint) []bool {
	m := make([]bool, int(n)+1)
	for i := 2; i <= int(n); i++ {
		m[i] = true
	}
	for i := 2; float64(i) <= math.Sqrt(float64(n)); i++ {
		j := i * i
		for j <= int(n) {
			m[j] = false
			j += i
		}

	}
	return m
}

type cdn3 struct {
	k     uint
	pmap  []bool
	plist []int
}

func newCdn3(n uint) (c cdn3) {
	c.k = n
	// create prime map as large as sqrt of (8k + 5) which is the term we need to do factoriing
	//c.pmap = pmap(uint(math.Floor(math.Sqrt(float64(8*n) + 5))))
	// create prime map as large as (8k + 5) to make it easy to check prime for factoring the number
	c.pmap = pmap(uint((8 * n) + 5))
	for i := 2; i < len(c.pmap); i++ {
		if c.pmap[i] {
			c.plist = append(c.plist, i)
		}
	}
	return c
}

func (cdn cdn3) a(k uint) int {
	return int(3*k + 2)
}

func (cdn cdn3) bc(k uint) (s [][2]int) {
	b := int(k + 1)
	c := int(8*k + 5)
	//bIsPrime := big.NewInt(int64(b)).ProbablyPrime(10)
	//cIsPrime := big.NewInt(int64(c)).ProbablyPrime(10)
	s = append(s, [2]int{1, b * b * c})
	factor := []int{}
	if cdn.pmap[c] {
		if b == 1 {
			return s
		}
		if cdn.pmap[b] {
			s = append(s, [2]int{b, c})
			return s
		} else {
			factor = append(factor, cdn.factor(b)...)
			factor = append(factor, factor...)
			factor = append(factor, c)
		}
	} else {
		if cdn.pmap[b] {
			factor = append(factor, b, b)
		} else {
			factor = append(factor, cdn.factor(b)...)
			factor = append(factor, factor...)
		}
		factor = append(factor, cdn.factor(c)...)
	}
	sort.SliceStable(factor, func(i, j int) bool {
		return factor[i] < factor[j]
	})
	fmt.Println("b =", b, "c =", c, "factor =>", factor, len(factor))
	var (
		prev       int
		pair, lone []int
	)
	for _, v := range factor {
		if prev == v {
			pair = append(pair, v)
			prev = 0
		} else if prev == 0 {
			prev = v
		} else {
			lone = append(lone, prev)
			prev = v
		}
	}
	if prev != 0 {
		lone = append(lone, prev)
	}
	fmt.Println("factor =>", "pair =", pair, "lone =", lone)
	return s
}

func (cdn cdn3) factor(n int) (s []int) {
	if n > 1 {
		if cdn.pmap[n] {
			return []int{n}
		}
		i := 0
		for {
			if n%cdn.plist[i] != 0 {
				i++
			} else {
				s = append(s, cdn.plist[i])
				n /= cdn.plist[i]
				if n == 1 {
					break
				} else if cdn.pmap[n] {
					s = append(s, n)
					break
				}
			}
		}
	}
	return s
}

func (cdn cdn3) abc(k uint) (s [][3]int) {
	for _, v := range cdn.bc(k) {
		s = append(s, [3]int{cdn.a(k), v[0], v[1]})
	}
	return s
}

func (cdn cdn3) String() string {
	var b strings.Builder
	for k := 0; k <= int(cdn.k); k++ {
		for _, v := range cdn.abc(uint(k)) {
			//fmt.Println(v)
			b.WriteString(fmt.Sprintln(v))
		}
	}
	return b.String()
}
