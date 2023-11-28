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

Input: @digits = (8, 1, 9)
Output: 981

981 % 3 == 0

Example 2

Input: @digits = (8, 6, 7, 1, 0)
Output: 8760

Example 3

Input: @digits = (1)
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
		input  digits
		output int
	}{
		{digits{8, 1, 9}, 981},
		{digits{8, 6, 7, 1, 0}, 8760},
		{digits{1}, -1},
	} {
		fmt.Println(reflect.DeepEqual(data.output, data.input.lot()))
	}
}

type digits []int

func (d digits) concat() int {
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

func (d digits) lot() int {
	slices.Sort(d)
	slices.Reverse(d)
	l := len(d)
	for i := l; i > 0; i-- {
		res, closer := d.permute(i)
		for v := range res {
			r := v.concat()
			if r%3 == 0 {
				closer()
				return r
			}
		}
	}
	return -1
}

// transcribed from https://docs.python.org/3/library/itertools.html#itertools.permutations
func (d digits) permute(r int) (res chan digits, closer func()) {
	res = make(chan digits)
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
		r0 := make(digits, r)
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
					rn := make(digits, r)
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
