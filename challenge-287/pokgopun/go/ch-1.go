//# https://theweeklychallenge.org/blog/perl-weekly-challenge-287/
/*#

Task 1: Strong Password

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a program to return the minimum number of steps required to make
   the given string very strong password. If it is already strong then
   return 0.

   Criteria:
- It must have at least 6 characters.
- It must contains at least one lowercase letter, at least one upper case letter
 and at least one digit.
- It shouldn't contain 3 repeating characters in a row.

   Following can be considered as one step:
- Insert one character
- Delete one character
- Replace one character with another

Example 1

Input: $str = "a"
Output: 5

Example 2

Input: $str = "aB2"
Output: 3

Example 3

Input: $str = "PaaSW0rd"
Output: 0

Example 4

Input: $str = "Paaasw0rd"
Output: 1

Example 5

Input: $str = "aaaaa"
Output: 2

Task 2: Valid Number
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type myRune struct {
	r *rune
}

func (mr *myRune) reset() {
	mr.r = nil
}

func (mr *myRune) set(r rune) {
	mr.r = &r
}

func (mr *myRune) equal(r rune) bool {
	if mr.r == nil {
		return false
	}
	return *mr.r == r
}

type runeChecker struct {
	consecutiveCount, consecutiveLimit, countConsecutive int
	r                                                    myRune
}

func (rc *runeChecker) check(r rune) {
	if rc.r.equal(r) {
		rc.consecutiveCount++
		if rc.consecutiveCount == rc.consecutiveLimit {
			rc.countConsecutive++
			rc.r.reset()
		}
	} else {
		rc.r.set(r)
		rc.consecutiveCount = 1
	}
}

type runeRange struct {
	first, last rune
	inExist     bool
}

func (rr *runeRange) check(r rune) {
	if !rr.inExist && r >= rr.first && r <= rr.last {
		rr.inExist = true
	}
}

type runeRanges []*runeRange

func (rrs runeRanges) check(r rune) {
	for _, rr := range rrs {
		rr.check(r)
	}
}

func (rrs runeRanges) countMissing() int {
	c := 0
	for _, rr := range rrs {
		if !rr.inExist {
			c++
		}
	}
	return c
}

func strongPassword(str string) int {
	l := len(str)
	if l == 0 {
		return 6
	}
	rrs := runeRanges{
		&runeRange{first: '0', last: '9'},
		&runeRange{first: 'A', last: 'Z'},
		&runeRange{first: 'a', last: 'z'},
	}
	rc := runeChecker{consecutiveLimit: 3}
	for _, v := range str {
		rrs.check(v)
		rc.check(v)
	}
	//fmt.Println(rrs.countMissing(), rc.countConsecutive, 6-min(6, l))
	return max(rrs.countMissing(), rc.countConsecutive, 6-min(6, l))
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"a", 5},
		{"aB2", 3},
		{"PaaSW0rd", 0},
		{"Paaasw0rd", 1},
		{"aaaaa", 2},
		{"aaaaaa", 2},
		{"aaaaaaa", 2},
		{"aaaaaaaa", 2},
		{"aaaaaaaaa", 3},
		{"aaaaaaaaaa", 3},
		{"aaa", 3},
		{"s3cret", 1},
		{"444o333", 2},
		{"44333", 2},
	} {
		//fmt.Println(data.input, data.output)
		io.WriteString(os.Stdout, cmp.Diff(strongPassword(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
