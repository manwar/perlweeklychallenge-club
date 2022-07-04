/* https://theweeklychallenge.org/blog/perl-weekly-challenge-172/

Task 2: Five-number Summary

Submitted by: [51]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to compute the five-number summary of the given set of
   integers.

   You can find the definition and example in the [52]wikipedia page.
*/
/*
lower and upper quartile using Method 1 mentioned in https://en.wikipedia.org/wiki/Quartile#Discrete_distributions

Computing methods
Discrete distributions
For discrete distributions, there is no universal agreement on selecting the quartile values.[3]

Method 1

1) Use the median to divide the ordered data set into two-halves.
 If there is an odd number of data points in the original ordered data set, do not include the median (the central value in the ordered list) in either half.
 If there is an even number of data points in the original ordered data set, split this data set exactly in half.

2) The lower quartile value is the median of the lower half of the data. The upper quartile value is the median of the upper half of the data.

This rule is employed by the TI-83 calculator boxplot and "1-Var Stats" functions.
*/

package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
)

func main() {
	var s []int
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			n, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			s = append(s, n)
		}
	} else {
		s = []int{2, 3, 5, 7, 11, 13}
	}
	sort.SliceStable(s, func(i, j int) bool {
		return s[i] < s[j]
	})
	l := len(s)
	w := bufio.NewWriter(os.Stdout)
	fmt.Fprintln(w, "Input:", s)
	name := []string{"sample minimum", "lower quartile", "median", "upper quartile", "sample maximum"}
	var value []float64
	if len(s) == 1 {
		for i := 0; i < 5; i++ {
			value = append(value, float64(s[0]))
		}
	} else {
		value = []float64{float64(s[0]), median(s[:l/2]), median(s), median(s[l/2+l%2:]), float64(s[l-1])}
	}
	for i, v := range name {
		fmt.Fprintln(w, v, ":", value[i])
	}
	w.Flush()
}
func median(s []int) float64 {
	l := len(s)
	if l == 1 {
		return float64(s[0])
	}
	if l%2 == 0 {
		return (float64(s[l/2]) + float64(s[l/2-1])) / 2
	}
	return float64(s[l/2])
}
