package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	n := getArgInt(10)
	var (
		ps string
		pc int
	)
	chk := checkPrime()
	for i := 1; i < 10000; i++ {
		sum := sumb(i)
		//fmt.Println("binary sum of", i, " is", sum)
		if chk(sum) {
			ps += fmt.Sprint(i, ", ")
			pc++
		}
		if pc == n {
			fmt.Println(ps[:len(ps)-2])
			break
		}
	}
}
func sumb(i int) (s int) {
	for j := i; j > 0; j /= 2 {
		s += j % 2
	}
	return s
}
func getArgInt(n int) int {
	if len(os.Args) > 1 {
		u, err := strconv.ParseUint(os.Args[1], 10, 64)
		if err != nil {
			log.Fatal(err)
		}
		n = int(u)
	}
	return n
}
func checkPrime() func(i int) bool {
	m := map[int]bool{}
	return func(i int) bool {
		is, ok := m[i]
		if ok {
			return is
		} else {
			if isPrime(i) {
				m[i] = true
				return true
			}
			m[i] = false
			return false
		}
	}
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
