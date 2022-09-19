/*
You are given an integer greater than 1.

Write a script to find the home prime of the given number.

In number theory, the home prime HP(n) of an integer n greater than 1 is the prime number obtained by repeatedly factoring the increasing concatenation of prime factors including repetitions.
*/
package main

import (
	"fmt"
	"log"
	"math/big"
	"os"

	"github.com/pokgopun/go/homeprime"
)

func main() {
	var s []*big.Int
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			n, ok := new(big.Int).SetString(v, 10)
			if !ok {
				log.Fatal("failed to set string for big.int")
			}
			s = append(s, n)
		}
	} else {
		for i := int64(2); i <= 64; i++ {
			s = append(s, big.NewInt(i))
		}
	}
	for _, v := range s {
		fmt.Printf("HP(%d) = %v\n", v, homeprime.NewHomePrime(v))
	}
}
