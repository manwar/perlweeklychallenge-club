package main

import "fmt"
import "math/big"

func isPrime(n int) bool {
	return big.NewInt(int64(n)).ProbablyPrime(0)
}
func sumDigits(n int) int {
	sum := 0
	for n > 0 {
		mod := n % 10
		sum += mod
		n -= mod
		n /= 10
	}
	return sum
}
func additivePrimes(maxPrime int) []int {
	var r []int
	for i := 2; i <= maxPrime; i += 1 {
		if isPrime(i) && isPrime(sumDigits(i)) {
			r = append(r, i)
		}
	}
	return r
}
func main() {
	fmt.Println(additivePrimes(100))
}
