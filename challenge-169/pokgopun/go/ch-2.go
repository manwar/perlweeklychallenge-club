/*
Write a script to generate first 20 Achilles Numbers. Please checkout wikipedia for more information.

An Achilles number is a number that is powerful but imperfect (not a perfect power). Named after Achilles, a hero of the Trojan war, who was also powerful but imperfect.

A positive integer n is a powerful number if, for every prime factor p of n, p^2 is also a divisor.

A number is a perfect power if it has any integer roots (square root, cube root, etc.).
*/
package main

import (
	"fmt"
	"log"
	"os"

	"github.com/pokgopun/go/achilles"
)

func main() {
	var n uint = 20
	if len(os.Args) > 1 {
		_, err := fmt.Sscanf(os.Args[1], "%d", &n)
		if err != nil {
			log.Fatal(err)
		}
	}
	fmt.Println(achilles.NewAchlls(n))
}
