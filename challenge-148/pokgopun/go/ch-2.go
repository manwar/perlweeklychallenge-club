// From https://math.stackexchange.com/questions/1885095/parametrization-of-cardano-triplet
// a = 3k + 2
// b^2 * c = (k+1)^2 * (8k + 5)
package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	var i uint = 2
	if len(os.Args) > 1 {
		n, err := strconv.ParseUint(os.Args[1], 10, 64)
		if err != nil {
			log.Fatal(err)
		}
		i = uint(n)
	}
	cdn := newCdn3(i)
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
	t1 := int(k + 1)
	t2 := int(8*k + 5)
	t := t1 * t1 * t2
	s = append(s, [2]int{1, t})
	factor := make(map[int]int)
	if cdn.pmap[t2] {
		if t1 == 1 {
			return s
		}
		if cdn.pmap[t1] {
			s = append(s, [2]int{t1, t2})
			return s
		} else {
			factor[t2] += 1
		}
	} else {
		for _, v := range cdn.factor(t2) {
			factor[v] += 1
		}
	}
	if cdn.pmap[t1] {
		factor[t1] += 2
	} else {
		for _, v := range cdn.factor(t1) {
			factor[v] += 2
		}
	}
	var pair []uint
	for k, v := range factor {
		if v >= 2 {
			pair = append(pair, uint(k))
		}
	}
	sort.SliceStable(pair, func(i, j int) bool {
		return pair[i] < pair[j]
	})
	for i := 1; i <= len(pair); i++ {
		getC, _ := getCombo(i, pair)
		for cmb := range getC {
			res := make(chan int)
			go func(cmb []uint) {
				findB(cmb, factor, 1, res)
				close(res)
			}(cmb)
			for v := range res {
				s = append(s, [2]int{v, t / (v * v)})
			}
		}
	}
	return s
}

func findB(s []uint, m map[int]int, b int, res chan<- int) {
	if len(s) == 0 {
		res <- b
		return
	}
	for i := 1; i <= m[int(s[0])]/2; i++ {
		b *= int(s[0])
		findB(s[1:], m, b, res)
	}
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
func getCombo(r int, e []uint) (<-chan []uint, func()) {
	c := []uint{}
	res := make(chan []uint, 50)
	done := make(chan struct{})
	go func() {
		cTree(r, e, c, res, done)
		close(res)
	}()
	return res, func() {
		close(done)
	}
}

func cTree(r int, e []uint, c []uint, res chan<- []uint, done chan struct{}) {
	if len(c) == r || len(c)+len(e) == r {
		s := make([]uint, r)
		l := copy(s, c)
		if l < r {
			copy(s[l:], e)
		}
		select {
		case <-done:
			return
		case res <- s:
		}
	} else {
		for i := 0; len(c)+len(e)-i >= r; i++ {
			cTree(r, e[i+1:], append(c, e[i]), res, done)
		}
	}
}
