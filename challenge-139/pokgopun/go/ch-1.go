/* https://theweeklychallenge.org/blog/perl-weekly-challenge-139/

TASK #1 › JortSort

Submitted by: [41]Mohammad S Anwar
     __________________________________________________________________

   You are given a list of numbers.

   Write a script to implement JortSort. It should return true/false
   depending if the given list of numbers are already sorted.

Example 1:

Input: @n = (1,2,3,4,5)
Output: 1

Since the array is sorted, it prints 1.

Example 2:

Input: @n = (1,3,2,4,5)
Output: 0

Since the array is NOT sorted, it prints 0.

*/
package main

import (
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
)

func main() {
	var n []int
	if len(os.Args) <= 1 {
		log.Fatal("please provide integers as arguments")
	}
	for _, v := range os.Args[1:] {
		i, err := strconv.Atoi(v)
		if err != nil {
			log.Fatal(err)
		}
		n = append(n, i)
	}
	fmt.Printf("Input: n = %v\nOutput: %t\n", n, sort.IntsAreSorted(n))
}
