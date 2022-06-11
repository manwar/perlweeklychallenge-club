package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	s := argInts()
	if len(s) == 0 {
		s = []int{5, 10, 20}
	}
	for _, n := range s {
		fmt.Println("Input: $n =", n)
		m := map[int]int{}
		for _, v := range factor(n) {
			m[v]++
		}
		//fmt.Println(m)
		o := -1
		if len(m)%2 == 0 {
			o = 1
		}
		for _, v := range m {
			if v > 1 {
				o = 0
				break
			}
		}
		fmt.Printf("Output: %d\n\n", o)
	}
}

func factor(n int) (s []int) {
	if n > 1 {
		chk, nxt, _ := primeUtil()
		p := 2
		if chk(n) {
			s = append(s, n)
		} else {
			for {
				if n%p != 0 {
					p = nxt(p)
				} else {
					s = append(s, p)
					n /= p
					if n == 1 {
						break
					} else if chk(n) {
						s = append(s, n)
						break
					}
				}
			}
		}
	}
	return s
}
func argInts() (s []int) {
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			i, err := strconv.Atoi(v)
			if err != nil {
				log.Fatal(err)
			}
			s = append(s, i)
		}
	}
	return s
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
