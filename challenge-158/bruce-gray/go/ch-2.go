package main

import "fmt"
import "math/big"

func isPrime(n int) bool {
	return big.NewInt(int64(n)).ProbablyPrime(0)
}
func cube(n int) int {
	return n * n * n
}
func cubanPrimes(limit int) []int {
	var r []int
	for i := 0; ; i += 1 {
		cubeDiff := cube(i+1) - cube(i)
		if isPrime(cubeDiff) {
			r = append(r, cubeDiff)
		}
		if cubeDiff > limit {
			break
		}
	}
	return r
}
func main() {
	fmt.Println(cubanPrimes(1000))
}
