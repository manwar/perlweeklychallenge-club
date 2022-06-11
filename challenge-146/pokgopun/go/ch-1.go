// From https://math.stackexchange.com/questions/1885095/parametrization-of-cardano-triplet
// a = 3k + 2
// b^2 * c = (k+1)^2 * (8k + 5)
package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
)

func main() {
	n := 10001
	if len(os.Args) > 1 {
		r, err := strconv.Atoi(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}
		n = r
	}
	for j := 50_000; j <= 1_000_000; j += 50_000 {
		var k int
		for i, v := range pmap(uint(j)) {
			if v {
				k++
				if k == n {
					fmt.Println(i)
					goto done
				}
			}
		}
	}
done:
}
func pmap(n uint) []bool {
	m := make([]bool, int(n)+1)
	for i := 2; i <= int(n); i++ {
		m[i] = true
	}
	for i := 2; float64(i) <= math.Sqrt(float64(n)); i++ {
		j := i * i
		for j <= int(n) {
			m[j] = false
			j += i
		}

	}
	return m
}
