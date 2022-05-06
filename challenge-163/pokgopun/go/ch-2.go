package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	var samples [][]int
	argInts := newArgInts()
	if len(argInts.val) > 0 && len(argInts.val) == len(argInts.valid) {
		samples = append(samples, argInts.val)
	} else {
		samples = append(samples, []int{1, 2, 3, 4, 5}, []int{1, 3, 5, 7, 9})
	}
	for _, v := range samples {
		fmt.Printf("Input: n = %v\n", v)
		fmt.Printf("Output: %v\n\n", msaSum(v))
	}
}

func msaSum(s []int) int {
	for len(s) > 1 {
		//fmt.Println(s)
		s = s[1:]
		for i := 1; i < len(s); i++ {
			s[i] += s[i-1]
		}
	}
	return s[0]
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
