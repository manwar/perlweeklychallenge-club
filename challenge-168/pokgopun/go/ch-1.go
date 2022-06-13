/*
The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)

A Perrin prime is a number in the Perrin sequence which is also a prime number.

Calculate the first 13 Perrin Primes.

f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]
*/
package main

import (
	"fmt"
	"log"
	"os"

	"github.com/pokgopun/go/perrinprime"
)

func main() {
	n := 13
	if len(os.Args) > 1 {
		_, err := fmt.Sscanf(os.Args[1], "%d", &n)
		if err != nil {
			log.Fatal(err)
		}
	}
	fmt.Printf("f(%d) = [%v]\n", n, perrinprime.NewPerrinPrime(n))
}
