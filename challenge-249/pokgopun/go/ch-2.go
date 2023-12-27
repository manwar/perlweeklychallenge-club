//# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
/*#

Task 2: DI String Match

Submitted by: [67]Mohammad S Anwar
     __________________________________________________________________

   You are given a string s, consisting of only the characters "D" and
   "I".

   Find a permutation of the integers [0 .. length(s)] such that for each
   character s[i] in the string:
s[i] == 'I' ⇒ perm[i] < perm[i + 1]
s[i] == 'D' ⇒ perm[i] > perm[i + 1]

Example 1

Input: $str = "IDID"
Output: (0, 4, 1, 3, 2)

Example 2

Input: $str = "III"
Output: (0, 1, 2, 3)

Example 3

Input: $str = "DDI"
Output: (3, 2, 0, 1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 31st December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"

	"github.com/google/go-cmp/cmp"
)

func main() {
	for _, data := range []struct {
		input  DI
		output permute
	}{
		{newDI("IDID"), permute{0, 4, 1, 3, 2}},
		{newDI("III"), permute{0, 1, 2, 3}},
		{newDI("DDI"), permute{3, 2, 0, 1}},
	} {
		fmt.Println(data.input.match(data.output))
	}
}

type DI []bool

func newDI(s string) DI {
	di := make(DI, len(s))
	for i, v := range s {
		switch v {
		case 'I':
			di[i] = false
		case 'D':
			di[i] = true
		default:
			return DI{}
		}
	}
	return di
}

func (di DI) match(p permute) bool {
	l := len(di)
	//fmt.Println("l=", l)
	pmtt := newPermutation(byte(l + 1))
	for pm := range pmtt.ch {
		//fmt.Println("-----")
		var (
			i int
			v bool
		)
		for _, v = range di {
			if v {
				if pm[i] > pm[i+1] {
					//fmt.Println("D", pm[i], pm[i+1])
					i++
					continue
				}
			} else {
				if pm[i] < pm[i+1] {
					//fmt.Println("I", pm[i], pm[i+1])
					i++
					continue
				}
			}
			break
		}
		//fmt.Println("i=", i)
		if i == l {
			//fmt.Println(pm, p, cmp.Diff(pm, p))
			if cmp.Diff(pm, p) == "" {
				close(pmtt.done)
				return true
			}
		}
	}
	return false
}

type permute []byte

type permutation struct {
	ch   chan permute
	done chan struct{}
}

func newPermutation(n byte) permutation {
	pmtt := permutation{make(chan permute), make(chan struct{})}
	go func() {
		s := pmString(n)
		pmtt.output(s, "")
		close(pmtt.ch)
	}()
	return pmtt
}

func (pmtt permutation) output(s, t string) {
	select {
	case <-pmtt.done:
	default:
		if len(s) > 0 {
			for i, v := range []byte(s) {
				pmtt.output(s[:i]+s[i+1:], t+string(v))
			}
		} else {
			select {
			case <-pmtt.done:
			case pmtt.ch <- permute(t):
			}
		}
	}
}

func pmString(n byte) string {
	bs := make([]byte, n)
	for n > 0 {
		n--
		bs[n] = n
	}
	//fmt.Println(bs)
	return string(bs)
}
