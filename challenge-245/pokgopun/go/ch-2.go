//# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/
/*#

Task 2: Largest of Three

Submitted by: [46]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers >= 0.

   Write a script to return the largest number formed by concatenating
   some of the given integers in any order which is also multiple of 3.
   Return -1 if none found.

Example 1

Input: @ints = (8, 1, 9)
Output: 981

981 % 3 == 0

Example 2

Input: @ints = (8, 6, 7, 1, 0)
Output: 8760

Example 3

Input: @ints = (1)
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 3rd December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"reflect"
	"slices"
)

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{8, 1, 9}, 981},
		{ints{8, 6, 7, 1, 0}, 8760},
		{ints{1}, -1},
		{ints{0, 0, 0}, 0},
		{ints{4, 8, 911}, 9114},
		{ints{8, 85, 0}, 8850},
		{ints{8, 89, 2}, 8982},
		{ints{8, 76, 0}, 8760},
		{ints{8, 94, 0}, 9480},
	} {
		fmt.Println(reflect.DeepEqual(data.output, data.input.lot()))
	}
}

type ints []int

func (d ints) sum() int {
	s := 0
	for _, v := range d {
		s += v
	}
	return s
}

func (d ints) concat() int {
	r := d[0]
	var n, t int
	for _, v := range d[1:] {
		n, t = v, 10
		for n > 10 {
			t *= 10
			n /= 10
		}
		r = r*t + v
	}
	return r
}

func (d ints) lot() int {
	max := -1
	l := len(d)
	for i := l; i > 0; i-- {
		res, closer := d.permute(i)
		for v := range res {
			if v.sum()%3 == 0 { // If a + b = c , then a ( mod N ) + b ( mod N ) ≡ c ( mod N ), we can filter lots of them out before concat
				r := v.concat()
				if r > max {
					max = r
				}
			}
		}
		closer()
	}
	return max
}

// transcribed from https://docs.python.org/3/library/itertools.html#itertools.permutations
func (d ints) permute(r int) (res chan ints, closer func()) {
	res = make(chan ints)
	done := make(chan struct{})
	n := len(d)
	idx := make([]int, n)
	for i := range idx {
		idx[i] = i
	}
	cyc := make([]int, r)
	for i := range cyc {
		cyc[i] = n - i
	}
	go func() {
		r0 := make(ints, r)
		copy(r0, d[:r])
		select {
		case <-done:
			close(res)
			return
		case res <- r0:
		}
		for {
			for i := r - 1; i >= 0; i-- {
				cyc[i]--
				if cyc[i] == 0 {
					idx = append(idx, idx[i])
					idx = slices.Delete(idx, i, i+1)
					cyc[i] = n - i
				} else {
					j := cyc[i]
					idx[i], idx[n-j] = idx[n-j], idx[i]
					rn := make(ints, r)
					for i, v := range idx[:r] {
						rn[i] = d[v]
					}
					select {
					case <-done:
						close(res)
						return
					case res <- rn:
					}
					break
				}
				if i == 0 {
					close(res)
					return
				}
			}
		}
		close(res)
	}()
	return res, func() {
		close(done)
	}
}
