// https://theweeklychallenge.org/blog/perl-weekly-challenge-229/
/*
Task 1: Lexicographic Order
Submitted by: Mohammad S Anwar
You are given an array of strings.

Write a script to delete element which is not lexicographically sorted (forwards or backwards) and return the count of deletions.

Example 1
Input: @str = ("abc", "bce", "cae")
Output: 1

In the given array "cae" is the only element which is not lexicographically sorted.
Example 2
Input: @str = ("yxz", "cba", "mon")
Output: 2

In the given array "yxz" and "mon" are not lexicographically sorted.
*/

package main

import (
	"fmt"
	"sort"
)

func byteToIntSlice(bs []byte) []int {
	is := make([]int, len(bs))
	for i, b := range bs {
		is[i] = int(b)
	}
	return is
}

func delUnsortedElem(s *[]string) int {
	var i, j int
	for i+j < len(*s) {
		is := byteToIntSlice([]byte((*s)[i]))
		if !sort.IntsAreSorted(is) {
			sort.SliceStable(is, func(i, j int) bool { return true })
			if !sort.IntsAreSorted(is) {
				copy((*s)[i:], (*s)[1:])
				j++
			} else {
				i++
			}
		} else {
			i++
		}
	}
	*s = (*s)[:len(*s)-j]
	return j
}

func main() {
	for _, data := range []struct {
		input  []string
		output int
	}{
		{[]string{"abc", "bce", "cae"}, 1},
		{[]string{"yxz", "cba", "mon"}, 2},
	} {
		fmt.Println(delUnsortedElem(&(data.input)) == data.output)
	}
}
