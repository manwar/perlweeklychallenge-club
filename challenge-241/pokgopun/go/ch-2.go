//# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/
/*#

Task 2: Prime Order

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of unique positive integers greater than 2.

   Write a script to sort them in ascending order of the count of their
   prime factors, tie-breaking by ascending value.

Example 1

Input: @int = (11, 8, 27, 4)
Output: (11, 4, 8, 27))

Prime factors of 11 => 11
Prime factors of  4 => 2, 2
Prime factors of  8 => 2, 2, 2
Prime factors of 27 => 3, 3, 3
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th November
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"cmp"
	"fmt"
	"math/big"
	"slices"

	"github.com/jbarham/primegen"
)

type processor struct {
	pg *primegen.Primegen
}

// func (p processor) factor() (s []uint64) {
func (p processor) countFactor(n uint64) (count uint64) {
	d := p.pg.Next()
	for {
		if n%d != 0 {
			d = p.pg.Next()
		} else {
			//s = append(s, d)
			count++
			n /= d
			if n == 1 {
				break
			} else if big.NewInt(int64(n)).ProbablyPrime(0) {
				//s = append(s, n)
				count++
				break
			}
		}
	}
	p.pg.Reset()
	//return s
	return count
}

func (p processor) pfSort(s []uint64) []uint64 {
	slices.Sort(s)
	slices.SortStableFunc(s, func(a, b uint64) int {
		return cmp.Compare(p.countFactor(a), p.countFactor(b))
	})
	return s
}

func main() {
	p := processor{pg: primegen.New()}
	for _, data := range []struct {
		inpt, otpt []uint64
	}{
		{[]uint64{11, 8, 27, 4}, []uint64{11, 4, 8, 27}},
		{[]uint64{11, 27, 8, 4}, []uint64{11, 4, 8, 27}},
	} {
		fmt.Println(slices.Equal(p.pfSort(data.inpt), data.otpt))
	}
}
