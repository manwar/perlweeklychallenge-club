//# https://theweeklychallenge.org/blog/perl-weekly-challenge-347/
/*#

Task 2: Format Phone Number

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a phone number as a string containing digits, space and
   dash only.

   Write a script to format the given phone number using the below rules:
1. Removing all spaces and dashes
2. Grouping digits into blocks of length 3 from left to right
3. Handling the final digits (4 or fewer) specially:
   - 2 digits: one block of length 2
   - 3 digits: one block of length 3
   - 4 digits: two blocks of length 2
4. Joining all blocks with dashes

Example 1

Input: $phone = "1-23-45-6"
Output: "123-456"

Example 2

Input: $phone = "1234"
Output: "12-34"

Example 3

Input: $phone = "12 345-6789"
Output: "123-456-789"

Example 4

Input: $phone = "123 4567"
Output: "123-45-67"

Example 5

Input: $phone = "123 456-78"
Output: "123-456-78"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 16th November
   2025.
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

func fpn(str string) string {
	var rs []rune
	var i, j, k int
	for _, v := range str {
		if v < '0' || v > '9' {
			continue
		}
		if i > 0 && i%3 == 0 {
			rs = append(rs, '-')
			j++
			k = j
		}
		rs = append(rs, v)
		i++
		j++
	}
	//fmt.Println(i, j, k)
	if j-k == 1 {
		rs[k-1], rs[k-2] = rs[k-2], rs[k-1]
	}
	return string(rs)
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"1-23-45-6", "123-456"},
		{"1234", "12-34"},
		{"12 345-6789", "123-456-789"},
		{"123 4567", "123-45-67"},
		{"123 456-78", "123-456-78"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(fpn(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
