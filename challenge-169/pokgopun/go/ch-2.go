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
	"math"
	"math/big"
	"os"
	"strconv"
	"strings"
)

func main() {
	var n uint = 20
	if len(os.Args) > 1 {
		_, err := fmt.Sscanf(os.Args[1], "%d", &n)
		if err != nil {
			log.Fatal(err)
		}
	}
	fmt.Println(newAchlsNum(n))
}

func newAchlsNum(n uint) (an achlsNum) {
	if n < 1 {
		log.Fatal("number must be greater than 0")
	}
	// build enough prime numbers to check n numbers of achilles
	an.n = int(n)
	k := 2 * an.n
	if k < 3 {
		k = 3
	}
	an.buildPrime(k)
	// First archilles is 1st prime power of three multiplied by square of 2nd prime => 72
	i := an.plist[0] * an.plist[0] * an.plist[0] * an.plist[1] * an.plist[1]
	an.vals = append(an.vals, i)
	i++
	for len(an.vals) < an.n {
		// pontential achilles would never be prime, fast-forward to the one that is not
		for big.NewInt(int64(i)).ProbablyPrime(0) {
			i++
		}
		// check if it is achilles and store or try next if it is not
		if an.isAchls(i) {
			an.vals = append(an.vals, i)
		}
		i++
	}
	//fmt.Println(an.plist)
	return an
}

type achlsNum struct {
	n     int
	pmap  []bool
	plist []int
	vals  []int
}

func (an achlsNum) isAchls(n int) bool {
	// achilles is powerful but with imperfect power
	m := make(map[int]int)
	var d int
	max := n
	for _, d = range an.plist {
		if d*d >= max {
			break
		}
		for n%d == 0 {
			m[d]++
			n /= d
		}
		// a prime factor happens less than twice is not powerful
		if m[d] != 0 && m[d] < 2 {
			return false
		}
	}
	// a remainder is a prime factor happens once, thus is not powerful
	if n > 1 {
		return false
	}
	// having less than two prime factors is not powerful
	l := len(m)
	if l < 2 {
		return false
	}
	// check for imperfect power
	// prime factor powers having a gcd other than 1 indicate a perfect power
	var min int
	// find the minimum of prime factor powers
	for _, v := range m {
		if min == 0 {
			min = v
		} else if min > v {
			min = v
		}
	}
	// check if there a valid gcd other than 1 up to min, if so, it idicates a perfect power thus not achilles
	for gcd := 2; gcd <= min; gcd++ {
		var sum int
		for _, v := range m {
			sum += v % gcd
		}
		if sum == 0 {
			return false
		}
	}
	// without any further objections, it is achilles
	return true
}

func (an achlsNum) String() string {
	var b strings.Builder
	for i := 0; i < an.n; i++ {
		b.WriteString(", " + strconv.Itoa(an.vals[i]))
	}
	return b.String()[2:]
}
func (an *achlsNum) buildPrime(n int) {
	an.pmap = make([]bool, int(n)+1)
	for i := 2; i <= n; i++ {
		an.pmap[i] = true
	}
	for i := 2; float64(i) <= math.Sqrt(float64(n)); i++ {
		j := i * i
		for j <= n {
			an.pmap[j] = false
			j += i
		}
	}
	an.plist = []int{}
	for i := 2; i < len(an.pmap); i++ {
		if an.pmap[i] {
			an.plist = append(an.plist, i)
		}
	}
}
