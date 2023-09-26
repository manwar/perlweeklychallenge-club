//# https://theweeklychallenge.org/blog/perl-weekly-challenge-236/
/*#

Task 1: Exact Change

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are asked to sell juice each costs $5. You are given an array of
   bills. You can only sell ONE juice to each customer but make sure you
   return exact change back. You only have $5, $10 and $20 notes. You do
   not have any change in hand at first.

   Write a script to find out if it is possible to sell to each customers
   with correct change.

Example 1

Input: @bills = (5, 5, 5, 10, 20)
Output: true

From the first 3 customers, we collect three $5 bills in order.
From the fourth customer, we collect a $10 bill and give back a $5.
From the fifth customer, we give a $10 bill and a $5 bill.
Since all customers got correct change, we output true.

Example 2

Input: @bills = (5, 5, 10, 10, 20)
Output: false

From the first two customers in order, we collect two $5 bills.
For the next two customers in order, we collect a $10 bill and give back a $5 bi
ll.
For the last customer, we can not give the change of $15 back because we only ha
ve two $10 bills.
Since not every customer received the correct change, the answer is false.

Example 3

Input: @bills = (5, 5, 5, 20)
Output: true

Task 2: Array Loops
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"maps"
)

type cash struct {
	objCnt map[int]int
	objs   []int
}

func newCash() (c cash) {
	c.objs = []int{20, 10, 5}
	c.objCnt = make(map[int]int)
	return c
}

func (c *cash) add(m map[int]int) {
	for _, v := range c.objs {
		c.objCnt[v] += m[v]
	}
}

func (c *cash) deduct(n int) bool {
	defer maps.DeleteFunc(c.objCnt, func(k, v int) bool {
		return k < 0
	})
	for _, v := range c.objs {
		c.objCnt[-v] = min(n/v, c.objCnt[v])
		n -= v * c.objCnt[-v]
	}
	if n != 0 {
		return false
	}
	for _, v := range c.objs {
		c.objCnt[v] -= c.objCnt[-v]
	}
	return true
}

func sellable(s []int) bool {
	c := newCash()
	for _, v := range s {
		c.add(map[int]int{v: 1})
		if c.deduct(v-5) == false {
			return false
		}
	}
	return true
}
func main() {
	for _, data := range []struct {
		input  []int
		output bool
	}{
		{[]int{5, 5, 5, 10, 20}, true},
		{[]int{5, 5, 10, 10, 20}, false},
		{[]int{5, 5, 5, 20}, true},
	} {
		fmt.Println(sellable(data.input) == data.output)
	}
}
