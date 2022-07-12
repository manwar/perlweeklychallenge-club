/* https://theweeklychallenge.org/blog/perl-weekly-challenge-173/
pTask 1: Esthetic Number
Submitted by: Mohammad S Anwar
You are given a positive integer, $n.

Write a script to find out if the given number is Esthetic Number.


An esthetic number is a positive integer where every adjacent digit differs from its neighbour by 1.


For example,

5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
120 is not an esthetic numner as |1 - 2| != |2 - 0| != 1
*/
package main

import (
	"fmt"
	"os"

	"github.com/pokgopun/go/esthetic"
)

func main() {
	if len(os.Args) < 2 {
		os.Args = append(os.Args, []string{"5456", "120"}...)
	}
	for _, v := range os.Args[1:] {
		fmt.Printf("IsEsthetic(%s) = %t\n", v, esthetic.IsEsthetic(v))
	}
}
