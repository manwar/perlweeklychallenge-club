package main

import (
	"fmt"
	"strconv"
)

func main() {
	last := 1
	count_prime := 0
	ps := []int{1, 1, 1}
	var dpps string
	for count_prime < 10 {
		p := ps[1] + ps[0]
		ps = append(ps[1:], p)
		if p != last {
			last = p
			if isPrime(p) {
				count_prime++
				dpps += strconv.Itoa(p) + ", "
			}
		}
	}
	fmt.Println(dpps[:len(dpps)-2])
}
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
