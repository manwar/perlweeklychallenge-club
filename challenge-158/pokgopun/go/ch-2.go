package main

import (
	"fmt"
)

const max = 1000

func main() {
	//i := 2
	i := 1
	var cp string
	for {
		//n := int(math.Pow(float64(i), 3) - math.Pow(float64(i-1), 3))
		n := 3*i*i + 3*i + 1
		if n > max {
			break
		}
		if isPrime(n) {
			cp += fmt.Sprint(", ", n)
		}
		i++
	}
	fmt.Println(cp[2:])
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
