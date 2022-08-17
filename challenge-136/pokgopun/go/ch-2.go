package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	var samples []uint64
	for _, v := range os.Args[1:] {
		n, err := strconv.ParseUint(v, 10, 64)
		if err != nil {
			break
		}
		samples = append(samples, n)
	}
	if len(samples) == 0 {
		samples = []uint64{16, 9, 15}
	}
	for _, n := range samples {
		s := fib(n)
		//fmt.Println(s)
		l := len(s)
		var res uint64
		for r := 2; r <= l; r++ {
			count(int(n), r, s, []uint64{}, &res)
		}
		fmt.Printf("Input: n = %d\nOutput: %d\n\n", n, res)
	}
}

func fib(n uint64) (s []uint64) {
	s = []uint64{0, 1}
	for s[len(s)-1] < n {
		s = append(s, s[len(s)-1]+s[len(s)-2])
	}
	return s[2 : len(s)-1]
}

func count(n, r int, e, c []uint64, res *uint64) uint64 {
	lc, le := len(c), len(e)
	if lc == r || lc+le == r {
		//fmt.Print(n)
		for _, v := range c {
			//fmt.Print("-", v)
			n -= int(v)
		}
		for _, v := range e[:r-lc] {
			//fmt.Print("-", v)
			n -= int(v)
		}
		//fmt.Println("=", n)
		if n == 0 {
			*res += 1
		}
		return 0
	} else {
		for i := 0; i <= lc+le-r; i++ {
			count(n, r, e[i+1:], append(c, e[i]), res)
		}
	}
	return *res
}
