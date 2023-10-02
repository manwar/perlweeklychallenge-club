// https://theweeklychallenge.org/blog/perl-weekly-challenge-231/
/*
Task 1: Min Max
Submitted by: Mohammad S Anwar
You are given an array of distinct integers.

Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.

Example 1
Input: @ints = (3, 2, 1, 4)
Output: (3, 2)

The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.
Example 2
Input: @ints = (3, 1)
Output: -1
Example 3
Input: @ints = (2, 1, 3)
Output: (2)

The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.
*/
package main

import "fmt"

type NotMinMax struct {
	s []int
}

func New(s []int) (nmm NotMinMax) {
	mn := Min(s)
	mx := Max(s)
	//fmt.Println("min, max =", mn, mx)
	var i, j, l int
	l = len(s)
	for j < l-1 {
		//fmt.Println("i =", i)
		//fmt.Println("s[i] =", s[i])
		if s[i] == mn || s[i] == mx {
			if i > 0 {
				//fmt.Println("s[:i-1], s[i+1:]...")
				s = append(s[:i], s[i+1:]...)
			} else {
				//fmt.Println("s = s[i+1:]")
				s = s[i+1:]
			}
		} else {
			i++
		}
		//fmt.Println(s[:i])
		j++
	}
	nmm.s = s[:i]
	return nmm
}

func (nmm NotMinMax) String() string {
	if len(nmm.s) == 0 {
		return "-1"
	}
	return fmt.Sprint(nmm.s)
}

func Min(s []int) (n int) {
	if len(s) == 0 {
		return -1
	}
	n = s[0]
	for _, v := range s[1:] {
		if v < n {
			n = v
		}
	}
	return n
}

func Max(s []int) (n int) {
	if len(s) == 0 {
		return -1
	}
	n = s[0]
	for _, v := range s[1:] {
		if v > n {
			n = v
		}
	}
	return n
}

func main() {

	for _, data := range []struct {
		input  []int
		output string
	}{
		{[]int{3, 2, 1, 4}, "[3 2]"},
		{[]int{3, 1}, "-1"},
		{[]int{2, 1, 3}, "[2]"},
	} {
		fmt.Println(New(data.input).String() == data.output)
	}
}
