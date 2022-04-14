package main

import (
	"fmt"
	"math"
)

func main() {
	i := 0
	maxIdx := 3_000
	for {
		i++
		if i > maxIdx-1 {
			break
		}
		pi := calPtg(i)
		j := i
		for {
			j++
			if j > maxIdx {
				break
			}
			pj := calPtg(j)
			if pj+pi < calPtg(j+1) {
				break
			}
			sumIdx := idxPtg(pj + pi)
			if sumIdx > 0 {
				diffIdx := idxPtg(pj - pi)
				if diffIdx > 0 {
					fmt.Printf("P(%v) + P(%v) => %v + %v = %v <= P(%v)\n", j, i, pj, pi, pj+pi, sumIdx)
					fmt.Printf("P(%v) - P(%v) => %v - %v = %v <= P(%v)\n", j, i, pj, pi, pj-pi, diffIdx)
					fmt.Print("\n")
					break
				}
			}
		}
	}
}

func calPtg(i int) int {
	return (3*i - 1) * i / 2
}

// idxPtg check if n is a Pentagon number and return its index if it is, it returns 0 if it is not
func idxPtg(n int) int {
	// find approximation of index of Pentagon number to start iterate up to find the actual index
	// p = i(3i - 1)/2 => 2p = 3i^2 - i => 3i^2 = 2p + i => i^2 = 2*p/3 + i/3 => i ~~ sqrt(2*p/3)
	i := int(math.Ceil(math.Sqrt(2 * float64(n) / 3)))
	//fmt.Println("i=", i, "=>p=", n)
	var p int
	for {
		p = (3*i - 1) * i / 2
		if p >= n {
			break
		}
		i++
	}
	//return p - n
	if p-n == 0 {
		return i
	}
	return 0
}
