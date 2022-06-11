package main

import (
	"fmt"
	"sort"
)

func main() {
	// find the first 8 fortunate number
	n := 8
	var (
		i     int
		j     int
		prime int
	)
	// declare with literal to allow append
	primes := []int{}
	fortunes := []int{}
	for len(fortunes) < n {
		// add next prime if not enough to calculate
		if i <= len(primes) || j <= len(primes) {
			primes = append(primes, nextPrime(prime))
			prime = primes[len(primes)-1]
		}
		pn := 1
		for k := 0; k <= j; k++ {
			pn *= primes[k]
		}
		m := primes[i]
		if isPrime(pn + m) {
			//fmt.Println("Found Fortunate number", m)
			fortunes = append(fortunes, m)
			// sort slice by standard library which need passing a closure that defined how to sort
			sort.Slice(fortunes, func(i, j int) bool {
				return fortunes[i] < fortunes[j]
			})
			// remove duplicated slice member by just writing unseen members back to the slice
			// this does not interfere for range because for range copy the slice before iterating
			// s to store slice's member already seen, initial value of 0 work because it's not a fortunate number
			// c is used as index to write unseen member back to the slice and counter of written at the same time
			// final step is to slice the original slice up to c
			var c, s int
			for _, v := range fortunes {
				if v == s {
					continue
				} else {
					fortunes[c] = v
					s = v
					c++
				}
			}
			fortunes = fortunes[:c]
			j++
			i = 0
		} else {
			i++
		}
	}
	fmt.Println(fortunes)
}

// function to check for prime number, copy from wiki
func isPrime(n int) bool {
	if n <= 3 {
		return n > 1
	} else if n%2 == 0 || n%3 == 0 {
		return false
	}
	for i := 5; i*i <= n; i += 6 {
		if n%i == 0 || n%(i+2) == 0 {
			return false
		}
	}
	return true
}

// a basic function to generate next prime number, basing on the isPrime function
// farily works on support calculating fortunate number up to 13 but freeze on 14
func nextPrime(n int) int {
	for {
		n++
		if isPrime(n) {
			return n
		}
	}
	return 0
}
