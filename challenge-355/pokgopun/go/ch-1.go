//# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/
/*#

Task 1: Thousand Separator

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int.

   Write a script to add thousand separator, , and return as string.

Example 1

Input: $int = 123
Output: "123"

Example 2

Input: $int = 1234
Output: "1,234"

Example 3

Input: $int = 1000000
Output: "1,000,000"

Example 4

Input: $int = 1
Output: "1"

Example 5

Input: $int = 12345
Output: "12,345"

Task 2: Mountain Array
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func ts(n int) string {
	k := 1000
	var (
		b   strings.Builder
		pad bool
		sep = ','
	)
	if n >= k {
		b.WriteString(ts(n / k))
		b.WriteRune(sep)
		n %= k
		pad = true
	}
	for {
		k /= 10
		if n >= k {
			break
		}
		if pad {
			b.WriteRune('0')
		}
	}
	for n > 0 {
		b.WriteRune('0' + rune(n/k))
		n %= k
		k /= 10
	}
	return b.String()
}

func main() {
	for _, data := range []struct {
		input  int
		output string
	}{
		{123, "123"},
		{1234, "1,234"},
		{1000000, "1,000,000"},
		{1, "1"},
		{12345, "12,345"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ts(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
