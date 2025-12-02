//# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/
/*#

Task 2: Shuffle Pairs

Submitted by: [52]E. Choroba
     __________________________________________________________________

   If two integers A <= B have the same digits but in different orders, we
   say that they belong to the same shuffle pair if and only if there is
   an integer k such that B = A * k where k is called the witness of the
   pair.

   For example, 1359 and 9513 belong to the same shuffle pair, because
   1359 * 7 = 9513.

   Interestingly, some integers belong to several different shuffle pairs.
   For example, 123876 forms one shuffle pair with 371628, and another
   with 867132, as 123876 * 3 = 371628, and 123876 * 7 = 867132.

   Write a function that for a given $from, $to, and $count returns the
   number of integers $i in the range $from <= $i <= $to that belong to at
   least $count different shuffle pairs.

   PS: Inspired by a conversation between Mark Dominus and Simon Tatham at
   Mastodon.

Example 1

Input: $from = 1, $to = 1000, $count = 1
Output: 0

There are no shuffle pairs with elements less than 1000.

Example 2

Input: $from = 1500, $to = 2500, $count = 1
Output: 3

There are 3 integers between 1500 and 2500 that belong to shuffle pairs.

1782, the other element is 7128 (witness 4)
2178, the other element is 8712 (witness 4)
2475, the other element is 7425 (witness 3)

Example 3

Input: $from = 1_000_000, $to = 1_500_000, $count = 5
Output: 2

There are 2 integers in the given range that belong to 5 different shuffle pairs
.

1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142

The witnesses are 2, 3, 4, 5, and 6 for both the integers.

Example 4

Input: $from = 13_427_000, $to = 14_100_000, $count = 2
Output: 11

6 integers in the given range belong to 3 different shuffle pairs, 5 integers be
long to 2 different ones.

Example 5

Input: $from = 1030, $to = 1130, $count = 1
Output: 2

There are 2 integers between 1020 and 1120 that belong to at least one shuffle p
air:
1035, the other element is 3105 (witness k = 3)
1089, the other element is 9801 (witness k = 9)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

type myInt int8

func setDgt(s []myInt, n int) {
	for n > 0 {
		s[n%10]++
		n /= 10
	}
}

func dgtPeak(n int) int {
	bs := []byte(strconv.Itoa(n))
	slices.Sort(bs)
	slices.Reverse(bs)
	l, _ := strconv.Atoi(string(bs))
	return l
}

type processor struct {
	source, target []myInt
}

func (p processor) process(from, to, count int) int {
	p.source = make([]myInt, 10)
	p.target = make([]myInt, 10)
	c := 0
	for n := from; n <= to; n++ {
		if p.isShufflePair(n, count) {
			c++
		}
	}
	return c
}

func (p processor) isShufflePair(n, count int) bool {
	setDgt(p.source, n)
	defer clear(p.source)
	l := dgtPeak(n) / n
	m := n
	c := 0
	for l > count-c {
		l--
		m = m + n
		setDgt(p.target, m)
		if slices.Equal(p.source, p.target) {
			c++
		}
		clear(p.target)
		if c == count {
			return true
		}
	}
	return false
}

func main() {
	var p processor
	for _, data := range []struct {
		frm, to, cnt, output int
	}{
		{1, 1000, 1, 0},
		{1500, 2500, 1, 3},
		{1_000_000, 1_500_000, 5, 2},
		{13_427_000, 14_100_000, 2, 11},
		{1030, 1130, 1, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(p.process(data.frm, data.to, data.cnt), data.output)) // blank if ok, otherwise show the difference
	}
}
