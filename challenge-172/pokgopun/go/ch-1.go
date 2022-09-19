/* https://theweeklychallenge.org/blog/perl-weekly-challenge-172/

Task 1: Prime Partition

Submitted by: [50]Mohammad S Anwar
     __________________________________________________________________

   You are given two positive integers, $m and $n.

   Write a script to find out the Prime Partition of the given number. No
   duplicates allowed.

   For example,
Input: $m = 18, $n = 2
Output: 5, 13 or 7, 11

Input: $m = 19, $n = 3
Output: 3, 5, 11

*/
package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/jbarham/primegen"
)

func main() {
	var m, n uint64
	if len(os.Args) > 2 {
		_, err := fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d %d", &m, &n)
		if err != nil {
			log.Fatal(err)
		}
	} else {
		log.Fatal("need two positive integers m and n")
	}
	pg := primegen.New()
	var (
		s []uint64
		p uint64
	)
	for {
		p = pg.Next()
		if p > m {
			break
		}
		s = append(s, p)
	}
	for _, v := range getCombo(int(n), s) {
		p = 0
		for _, i := range v {
			p += i
		}
		if p == m {
			fmt.Println(v)
		}
	}
}
func getCombo(n int, e []uint64) (r [][]uint64) {
	var c []uint64
	var sc []uint64
	cTree(n, e, c, func(s []uint64) {
		sc = make([]uint64, len(s))
		copy(sc, s)
		r = append(r, sc)
	})
	return r
}
func cTree(n int, e []uint64, c []uint64, f func(s []uint64)) {
	if len(c) == n || len(c)+len(e) == n {
		f(append(c, e...)[:n])
	} else {
		for i := 0; len(c)+len(e)-i >= n; i++ {
			cTree(n, e[i+1:], append(c, e[i]), f)
		}
	}
}
