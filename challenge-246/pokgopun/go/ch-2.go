//# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/
/*#

Task 2: Linear Recurrence of Second Order

Submitted by: [47]Jorg Sommrey
     __________________________________________________________________

   You are given an array @a of five integers.

   Write a script to decide whether the given integers form a linear
   recurrence of second order with integer factors.

   A linear recurrence of second order has the form
a[n] = p * a[n-2] + q * a[n-1] with n > 1

where p and q must be integers.

Example 1

Input: @a = (1, 1, 2, 3, 5)
Output: true

@a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1]
with a[0] = 1 and a[1] = 1.

Example 2

Input: @a = (4, 2, 4, 5, 7)
Output: false

a[1] and a[2] are even. Any linear combination of two even numbers with integer
factors is even, too.
Because a[3] is odd, the given numbers cannot form a linear recurrence of second
 order with integer factors.

Example 3

Input: @a = (4, 1, 2, -3, 8)
Output: true

a[n] = a[n-2] - 2 * a[n-1]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 10th December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import "fmt"

type equation struct {
	a, b, c int // a*p + b*q = c
}

type answer struct {
	isValid bool // true if both p and q are ints
	p, q    int  // Only correct if isValid==true
}

func (eqt equation) solve(aeqt equation) answer {
	// q = dvd / dvs
	dvd, dvs := aeqt.a*eqt.c-eqt.a*aeqt.c, aeqt.a*eqt.b-aeqt.b*eqt.a
	if dvd%dvs != 0 {
		return answer{false, 0, 0}
	}
	q := dvd / dvs
	//fmt.Println(eqt, aeqt, dvd, dvs)
	// p = dvd / dvs
	dvd, dvs = eqt.c-eqt.b*q, eqt.a
	if dvd%dvs != 0 {
		return answer{false, 0, 0}
	}
	p := dvd / dvs
	return answer{true, p, q}
}

type equations []equation

func newEquations(ints int5) equations {
	eqts := make(equations, 3)
	for i := 0; i < 3; i++ {
		eqts[i] = equation{ints[i], ints[i+1], ints[i+2]}
	}
	return eqts
}

func (eqts equations) isValid() bool {
	anss := make(map[answer]struct{})
	for i := 0; i < 2; i++ {
		ans := eqts[i].solve(eqts[i+1])
		//fmt.Println(ans)
		if ans.isValid == false {
			return false
		}
		anss[ans] = struct{}{}
		if len(anss) > 1 {
			return false
		}
	}
	return true
}

type int5 [5]int

func main() {
	for _, data := range []struct {
		input  int5
		output bool
	}{
		{int5{1, 1, 2, 3, 5}, true},
		{int5{4, 2, 4, 5, 7}, false},
		{int5{4, 1, 2, -3, 8}, true},
	} {
		fmt.Println(newEquations(data.input).isValid() == data.output)

	}
}
