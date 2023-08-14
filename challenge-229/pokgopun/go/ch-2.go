// https://theweeklychallenge.org/blog/perl-weekly-challenge-229/
/*
Task 2: Two out of Three
Submitted by: Mohammad S Anwar
You are given three array of integers.

Write a script to return all the elements that are present in at least 2 out of 3 given arrays.

Example 1
Input: @array1 = (1, 1, 2, 4)
       @array2 = (2, 4)
       @array3 = (4)
Ouput: (2, 4)
Example 2
Input: @array1 = (4, 1)
       @array2 = (2, 4)
       @array3 = (1, 2)
Ouput: (1, 2, 4)
*/

package main

import (
	"fmt"
	"reflect"
	"sort"
)

func intSliceToSet(s []int) (r []int) {
	m := make(map[int]int, len(s))
	for _, v := range s {
		m[v]++
	}
	for k := range m {
		r = append(r, k)
	}
	return r
}

func dupElemSlice(ss ...[]int) (r []int) {
	m := map[int]int{}
	for _, s := range ss {
		s = intSliceToSet(s)
		for _, v := range s {
			m[v]++
		}
	}
	for k, v := range m {
		if v > 1 {
			r = append(r, k)
		}
	}
	sort.Ints(r)
	return r
}

func main() {
	for _, data := range []struct {
		input  [][]int
		output []int
	}{
		{
			[][]int{
				[]int{1, 1, 2, 4},
				[]int{2, 4},
				[]int{4},
			},
			[]int{2, 4},
		},
		{
			[][]int{
				[]int{4, 1},
				[]int{2, 4},
				[]int{1, 2},
			},
			[]int{1, 2, 4},
		},
	} {
		fmt.Println(reflect.DeepEqual(dupElemSlice(data.input...), data.output))
	}
}
