//# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/
/*#

Task 1: Secret Santa

Submitted by: [54]Andreas Voegele
     __________________________________________________________________

   Secret Santa is a Christmas tradition in which members of a group are
   randomly assigned a person to whom they give a gift.

   You are given a list of names. Write a script that tries to team
   persons from different families.

Example 1

The givers are randomly chosen but don't share family names with the receivers.

Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                 'Mrs. Anwar',
                 'Mr. Conway',
                 'Mr. Cross',
                );

Output:

    Mr. Conway -> Mr. Wall
    Mr. Anwar -> Mrs. Wall
    Mrs. Wall -> Mr. Anwar
    Mr. Cross -> Mrs. Anwar
    Mr. Wall -> Mr. Conway
    Mrs. Anwar -> Mr. Cross

Example 2

One gift is given to a family member.

Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                );

Output:

    Mr. Anwar -> Mr. Wall
    Mr. Wall -> Mrs. Wall
    Mrs. Wall -> Mr. Anwar

Task 2: Most Frequent Letter Pair
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"math/rand"
	"slices"
	"strings"
)

type buddy [][2]string

func newBuddy(s []string) buddy {
	l := len(s)
	r := make([][2]string, l)
	var se [][3]string
	for _, v := range s {
		se = append(se, [3]string{v, strings.Split(v, " ")[1], ""})
	}
	//fmt.Println(se)
	for i, v := range se {
		st := make([][3]string, l)
		copy(st, se)
		st = slices.DeleteFunc(st, func(a [3]string) bool {
			return a[1] == v[1] || a[2] != ""
		})
		if len(st) == 0 {
			st = make([][3]string, l)
			copy(st, se)
			st = slices.DeleteFunc(st, func(a [3]string) bool {
				return a[0] == v[0] || a[2] != ""
			})
		}
		var giver string
		if i == l-2 && se[l-1][2] == "" {
			giver = se[l-1][0]
		} else {
			giver = st[rand.Intn(len(st))][0]
		}
		se[slices.Index(s, giver)][2] = "a"
		r[i] = [2]string{giver, v[0]}
	}
	return r
}

func (bd buddy) String() string {
	r := ""
	for _, v := range bd {
		r += fmt.Sprintln(v[0], "->", v[1])
	}
	return r
}

func main() {
	for _, v := range [][]string{
		[]string{
			"Mr. Wall",
			"Mrs. Wall",
			"Mr. Anwar",
			"Mrs. Anwar",
			"Mr. Conway",
			"Mr. Cross",
		},
		[]string{
			"Mr. Wall",
			"Mrs. Wall",
			"Mr. Anwar",
		},
	} {
		fmt.Printf("Input: @names = %v\nOutput:\n%s\n", v, newBuddy(v))
	}
}
