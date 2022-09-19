/*
Write a script to generate all Semiprime number <= 100.

For more information about Semiprime, please checkout the wikipedia page.


In mathematics, a semiprime is a natural number that is the product of exactly two prime numbers. The two primes in the product may equal each other, so the semiprimes include the squares of prime numbers.

Usage:
To get Semiprime number <= 10
go run ch-1.go 10
4, 6, 9, 10
*/
package main

import (
	"fmt"
	"log"
	"os"

	"github.com/pokgopun/go/semiprime"
)

func main() {
	var n uint = 100
	if len(os.Args) > 1 {
		_, err := fmt.Sscanf(os.Args[1], "%d", &n)
		if err != nil {
			log.Fatal(err)
		}
	}
	fmt.Println(semiprime.NewSemiprime(n))
}
