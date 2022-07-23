/* https://theweeklychallenge.org/blog/perl-weekly-challenge-174/
Task 1: Disarium Numbers
Submitted by: Mohammad S Anwar
Write a script to generate first 19 Disarium Numbers.


A disarium number is an integer where the sum of each digit raised to the power of its position in the number, is equal to the number.


For example,

518 is a disarium number as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518
*/
package main

import (
	"fmt"
	"strconv"
)

func main() {
	count := 19
	var (
		dp, sum uint
		b       []byte
		//skip       uint
	)
	for i := uint(0); i < 10_000_000; i++ {
		//fmt.Println("===>", i)
		b = []byte(strconv.FormatUint(uint64(i), 10))
		/*
			sum = 0
			for _, v := range b {
				sum += uint(v - 48)
			}
			if sum%2 != i%2 {
				skip++
				continue
			}
		*/
		sum = 0
		for p, d := range b {
			d -= 48
			dp = uint(d)
			for j := 0; j < p; j++ {
				dp *= uint(d)
			}
			//fmt.Println(d, "^", p+1, "=", dp)
			sum += dp
		}
		if sum == i {
			//fmt.Println(sum, "-->", count)
			fmt.Println(sum)
			count--
			if count == 0 {
				break
			}
		}
	}
	//fmt.Println("skip =", skip)
}
