package main

import "github.com/jbarham/primegen"

func bigAndLittleOmega(number, mode uint64) int {
	pg := primegen.New()
	m := make(map[uint64]int)
	n := number
	h := n / 2
	c := 0

	for n > 1 {
		p := pg.Next()
		if p > h {
			c++
			m[n]++
			break
		}
		for n%p == 0 {
			if mode == 0 {
				if m[p] == 0 {
					c++
				}
			} else {
				c++
			}
			m[p]++
			n /= p
		}
	}
	return c
}
