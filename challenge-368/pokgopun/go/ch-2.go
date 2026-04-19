//# https://theweeklychallenge.org/blog/perl-weekly-challenge-368/
/*#

Task 2: Big and Little Omega

Submitted by: [63]Roger Bell_West
     __________________________________________________________________

   You are given a positive integer $number and a mode flag $mode. If the
   mode flag is zero, calculate little omega (the count of all distinct
   prime factors of that number). If it is one, calculate big omega (the
   count of all prime factors including duplicates).

Example 1

Input: $number = 100061
       $mode = 0
Output: 3

   Prime factors are 13, 43, 179. Count is 3.

Example 2

Input: $number = 971088
       $mode = 0
Output: 3

   Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.

Example 3

Input: $number = 63640
       $mode = 1
Output: 6

   Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.

Example 4

Input: $number = 988841
       $mode = 1
Output: 2

Example 5

Input: $number = 211529
       $mode = 0
Output: 2
     __________________________________________________________________

   By submitting a response to the challenge you agree that your name or
   pseudonym, any photograph you supply and any other personal information
   contained in your submission may be published on this website and the
   associated mobile app. Last date to submit the solution 23:59 (UK Time)
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
	"github.com/jbarham/primegen"
)

func balo(number, mode uint64) int {
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
		//fmt.Println(m, p, n)
	}
	//fmt.Println(m)
	return c
}

func main() {
	for _, data := range []struct {
		number, mode uint64
		output       int
	}{
		{100061, 0, 3},
		{971088, 0, 3},
		{63640, 1, 6},
		{988841, 1, 2},
		{211529, 0, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(balo(data.number, data.mode), data.output)) // blank if ok, otherwise show the difference
	}
}
