package main

import (
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
)

func main() {
	l := 20
	if len(os.Args) > 1 {
		i, err := strconv.Atoi(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}
		l = i
	}
	ltp := []int{}
	chk, nxt, _ := primeUtil()
	re := regexp.MustCompile(`0`)
	p := 9
	for i := 0; i < 100; i++ {
		p = nxt(p)
		s := []byte(strconv.Itoa(p))
		if re.MatchString(string(s)) {
			continue
		}
		count := 1
		for j := 1; j < len(s); j++ {
			tp, err := strconv.Atoi(string(s[j:]))
			if err != nil {
				log.Fatal(err)
			}
			if !chk(tp) {
				break
			}
			count++
		}
		if count == len(s) {
			ltp = append(ltp, p)
			if len(ltp) == l {
				break
			}
		}
	}
	//fmt.Println(len(ltp), ltp)
	fmt.Println(ltp)
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
