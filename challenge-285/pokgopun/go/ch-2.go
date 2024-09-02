//# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/
/*#

Task 2: Making Change

Submitted by: [50]David Ferrone
     __________________________________________________________________

   Compute the number of ways to make change for given amount in cents. By
   using the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in
   how many distinct ways can the total value equal to the given amount?
   Order of coin selection does not matter.
A penny (P) is equal to 1 cent.
A nickel (N) is equal to 5 cents.
A dime (D) is equal to 10 cents.
A quarter (Q) is equal to 25 cents.
A half-dollar (HD) is equal to 50 cents.

Example 1

Input: $amount = 9
Ouput: 2

1: 9P
2: N + 4P

Example 2

Input: $amount = 15
Ouput: 6

1: D + 5P
2: D + N
3: 3N
4: 2N + 5P
5: N + 10P
6: 15P

Example 3

Input: $amount = 100
Ouput: 292
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th September
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func mc(a int) int {
	c := 0
	for c50 := range a/50 + 1 {
		for c25 := range (a-50*c50)/25 + 1 {
			for c10 := range (a-50*c50-25*c25)/10 + 1 {
				for c5 := range (a-50*c50-25*c25-10*c10)/5 + 1 {
					for c1 := range (a - 50*c50 - 25*c25 - 10*c10 - 5*c5) + 1 {
						if 50*c50+25*c25+10*c10+5*c5+c1 == a {
							c++
						}
					}
				}
			}
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input, output int
	}{
		{9, 2},
		{15, 6},
		{100, 292},
	} {
		io.WriteString(os.Stdout, cmp.Diff(mc(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
