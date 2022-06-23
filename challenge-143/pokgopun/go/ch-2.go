/*
You are given a positive number, $n.

Write a script to find out if the given number is Stealthy Number.

A positive integer N is stealthy, if there exist positive integers a, b, c, d such that a * b = c * d = N and a + b = c + d + 1.
*/
package main

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/pokgopun/go/stealthy"
)

func main() {
	var nums []uint
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			n, err := strconv.ParseUint(v, 10, 64)
			if err != nil {
				log.Fatal(err)
			}
			nums = append(nums, uint(n))
		}
	} else {
		nums = []uint{36, 12, 6}
	}
	for _, v := range nums {
		fmt.Printf("Input: n = %d\nOutput: %t\n\n", v, stealthy.IsStealthy(v))
	}
}
