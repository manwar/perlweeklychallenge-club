package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func gcd(n int, m int) int {

	for m != 0 {
		n, m = m, n%m
	}

	return n
}

func totient(n int) int {

	totient := 1

	for this := n; this > 1; this-- {
		if !(n%this == 0 || gcd(n, this) > 1) {
			totient++
		}
	}

	return totient
}

func main() {

	var max int
	var err error

	if 2 == len(os.Args) {
		max, err = strconv.Atoi(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}
	} else {
		log.Fatal("ERROR: Requires at exactly one integer argumemt")
	}

	cache := map[int]int{}
	perfect := []int{}
	this := 2

	for len(perfect) < max {

		sum, iter := 0, this
		for iter > 1 {

			if cache[iter] == 0 {
				cache[iter] = totient(iter)
			}
			iter = cache[iter]

			sum += iter
		}

		if this == sum {
			perfect = append(perfect, this)
		}

		this++
	}

	fmt.Println(perfect)

}
