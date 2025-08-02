//# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
/*#

Task 1: Unique Occurrences

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return 1 if the number of occurrences of each value
   in the given array is unique or 0 otherwise.

Example 1

Input: @ints = (1,2,2,1,1,3)
Output: 1

The number 1 occurred 3 times.
The number 2 occurred 2 times.
The number 3 occurred 1 time.

All occurrences are unique, therefore the output is 1.

Example 2

Input: @ints = (1,2,3)
Output: 0

Example 3

Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
Output: 1

Task 2: Dictionary Rank
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

type myMap map[int]int

func newMyMap() myMap {
	return make(myMap)
}

func (mm myMap) proc(is ints) {
	clear(mm)
	for _, v := range is {
		mm[v]++
	}
}

func (mm myMap) keys() ints {
	var s ints
	for k := range mm {
		s = append(s, k)
	}
	return s
}

func (mm myMap) values() ints {
	var s ints
	for _, v := range mm {
		s = append(s, v)
	}
	return s
}

func (mm myMap) uo(is ints) bool {
	mm.proc(is)
	//fmt.Println("mm = ", mm)
	count_uniq_elem := len(mm.keys())
	//fmt.Println("count_uniq_elem =", count_uniq_elem)
	mm.proc(mm.values())
	//fmt.Println("mm = ", mm)
	count_uniq_occur := len(mm.keys())
	//fmt.Println("count_uniq_occur =", count_uniq_occur)
	return count_uniq_elem == count_uniq_occur
}

func main() {
	mm := newMyMap()
	for _, data := range []struct {
		input  ints
		output bool
	}{
		{ints{1, 2, 2, 1, 1, 3}, true},
		{ints{1, 2, 3}, false},
		{ints{-2, 0, 1, -2, 1, 1, 0, 1, -2, 9}, true},
	} {
		//fmt.Println(data.input)
		io.WriteString(os.Stdout, cmp.Diff(mm.uo(data.input), data.output)) // blank if ok, otherwise show the differences
	}
}
