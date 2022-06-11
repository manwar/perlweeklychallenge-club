package main

import (
	"fmt"
	"strconv"
)

const max = 100

func main() {
	chk, nxt, _ := primeUtil()
	p := 2
	ap := strconv.Itoa(p)
	for {
		p = nxt(p)
		if p > max {
			break
		}
		if p >= 10 {
			n := p
			sum := 0
			for {
				r := n % 10
				sum += r
				if n = n / 10; n == 0 {
					break
				}
			}
			if !chk(sum) {
				continue
			}
		}
		//fmt.Println(p)
		ap += ", " + strconv.Itoa(p)
	}
	fmt.Println(ap)
}

func primeUtil() (func(i int) bool, func(i int) int, func()) {
	m := map[int]bool{}
	return func(i int) bool {
			is, ok := m[i]
			if ok {
				//fmt.Println("### check prime from cache ###")
				return is
			} else {
				if isPrime(i) {
					m[i] = true
					return true
				}
				m[i] = false
				return false
			}
		}, func(i int) int {
			for {
				i++
				is, ok := m[i]
				if ok {
					//fmt.Println("### check next number from cache ###")
					if is {
						return i
					} else {
						continue
					}
				} else {
					if isPrime(i) {
						m[i] = true
						return i
					}
					m[i] = false
				}
			}
		}, func() {
			fmt.Println("=>", m)
		}
}
func isPrime(n int) bool {
	//fmt.Println("In isPrime")
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
