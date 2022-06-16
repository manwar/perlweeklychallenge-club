/*
Write a script to generate first 20 Brilliant Numbers.

Brilliant numbers are numbers with two prime factors of the same length.

The number should have exactly two prime factors, i.e. it’s the product of two primes of the same length.
*/
package main

import (
	"fmt"
	"log"
	"os"

	"github.com/pokgopun/go/brilliant"
)

func main() {
	var n uint = 20
	if len(os.Args) > 1 {
		_, err := fmt.Sscanf(os.Args[1], "%d", &n)
		if err != nil {
			log.Fatal(err)
		}
	}
	fmt.Println(brilliant.NewBrllnt(n))
}
