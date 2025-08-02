//# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/
/*#

Task 2: Distribute Elements

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct integers, @ints.

   Write a script to distribute the elements as described below:
1) Put the 1st element of the given array to a new array @arr1.
2) Put the 2nd element of the given array to a new array @arr2.

   Once you have one element in each arrays, @arr1 and @arr2, then follow
   the rule below:
If the last element of the array @arr1 is greater than the last
element of the array @arr2 then add the first element of the
given array to @arr1 otherwise to the array @arr2.

   When done distribution, return the concatenated arrays. @arr1 and
   @arr2.

Example 1

Input: @ints = (2, 1, 3, 4, 5)
Output: (2, 3, 4, 5, 1)

1st operation:
Add 1 to @arr1 = (2)

2nd operation:
Add 2 to @arr2 = (1)

3rd operation:
Now the last element of @arr1 is greater than the last element
of @arr2, add 3 to @arr1 = (2, 3).

4th operation:
Again the last element of @arr1 is greate than the last element
of @arr2, add 4 to @arr1 = (2, 3, 4)

5th operation:
Finally, the last element of @arr1 is again greater than the last
element of @arr2, add 5 to @arr1 = (2, 3, 4, 5)

Mow we have two arrays:
@arr1 = (2, 3, 4, 5)
@arr2 = (1)

Concatenate the two arrays and return the final array: (2, 3, 4, 5, 1).

Example 2

Input: @ints = (3, 2, 4)
Output: (3, 4, 2)

1st operation:
Add 1 to @arr1 = (3)

2nd operation:
Add 2 to @arr2 = (2)

3rd operation:
Now the last element of @arr1 is greater than the last element
of @arr2, add 4 to @arr1 = (3, 4).

Mow we have two arrays:
@arr1 = (3, 4)
@arr2 = (2)

Concatenate the two arrays and return the final array: (3, 4, 2).

Example 3

Input: @ints = (5, 4, 3 ,8)
Output: (5, 3, 4, 8)

1st operation:
Add 1 to @arr1 = (5)

2nd operation:
Add 2 to @arr2 = (4)

3rd operation:
Now the last element of @arr1 is greater than the last element
of @arr2, add 3 to @arr1 = (5, 3).

4th operation:
Again the last element of @arr2 is greate than the last element
of @arr1, add 8 to @arr2 = (4, 8)

Mow we have two arrays:
@arr1 = (5, 3)
@arr2 = (4, 8)

Concatenate the two arrays and return the final array: (5, 3, 4, 8).
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 19th May 2024.
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

type ints []int

func (is ints) distElem() ints {
	l := len(is)
	x, y, z := 0, 1, 2
	var i int
	for z < l {
		if is[x] > is[y] {
			i = is[z]
			copy(is[z:], is[z+1:])
			x++
			copy(is[x+1:], is[x:])
			is[x] = i
		}
		y++
		z++
	}
	return is
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{2, 1, 3, 4, 5}, ints{2, 3, 4, 5, 1}},
		{ints{3, 2, 4}, ints{3, 4, 2}},
		{ints{5, 4, 3, 8}, ints{5, 3, 4, 8}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.distElem(), data.output)) // blank if ok, otherwise show the difference
	}
}
