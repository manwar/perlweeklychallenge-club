/*
	https://theweeklychallenge.org/blog/perl-weekly-challenge-201/

Task 1: Missing Numbers
Submitted by: Mohammad S Anwar
You are given an array of unique numbers.

Write a script to find out all missing numbers in the range 0..$n where $n is the array size.

Example 1
Input: @array = (0,1,3)
Output: 2

The array size i.e. total element count is 3, so the range is 0..3.
The missing number is 2 in the given array.

Example 2
Input: @array = (0,1)
Output: 2

The array size is 2, therefore the range is 0..2.
The missing number is 2.
*/
package main

import (
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	a := []uint64{}
	var (
		i   uint64
		err error
	)
	for _, v := range os.Args[1:] {
		i, err = strconv.ParseUint(v, 10, 64)
		if err != nil {
			log.Fatal(err)
		}
		a = append(a, i)
	}
	if len(a) == 0 {
		a = []uint64{0, 1, 3}
	}
	alen := len(a)
	sort.SliceStable(a, func(i, j int) bool {
		return a[i] < a[j]
	})
	s := make([]bool, alen+1)
	for _, v := range a {
		if int(v) > alen {
			break
		}
		s[v] = true
	}
	var b strings.Builder
	for i := range s {
		if s[i] == false {
			b.WriteString(", " + strconv.Itoa(i))
		}
	}
	fmt.Printf("Input: array = %v\nOutput: %v\n", a, b.String()[2:])
}
