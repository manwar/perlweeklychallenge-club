package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	var samples [][]int
	argInts := newArgInts()
	if len(argInts.val) > 1 && len(argInts.val) == len(argInts.valid) {
		samples = append(samples, argInts.val)
	} else {
		samples = append(samples, []int{1, 2, 3}, []int{2, 3, 4})
	}
	for _, v := range samples {
		fmt.Printf("Input: n = %v\nOutput: %v\n\n", v, sumBitwise(v))
	}
}

func sumBitwise(ints []int) (sum int) {
	for _, v := range getCombo(2, ints) {
		for i := 0; i < len(v); i += 2 {
			sum += v[i] & v[i+1]
		}
	}
	return sum
}

func getCombo(n int, e []int) (r [][]int) {
	c := []int{}
	cTree(n, e, c, func(s []int) {
		r = append(r, s)
	})
	return r
}
func cTree(n int, e []int, c []int, f func(s []int)) {
	if len(c) == n || len(c)+len(e) == n {
		s := append(c, e...)
		f(s[:n])
	} else {
		for i := 0; len(c)+len(e)-i >= n; i++ {
			cTree(n, e[i+1:], append(c, e[i]), f)
		}
	}
}

type argInts struct {
	valid map[int]bool
	val   []int
}

func newArgInts() (ais argInts) {
	ais.valid = map[int]bool{}
	for i, v := range os.Args[1:] {
		r, err := strconv.Atoi(v)
		if err == nil {
			ais.valid[i] = true
		}
		ais.val = append(ais.val, r)
	}
	return ais
}
