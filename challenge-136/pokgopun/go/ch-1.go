package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	var samples [][]uint64
	if len(os.Args) > 2 {
		for i := 1; i <= 2; i++ {
			n, err := strconv.ParseUint(os.Args[i], 10, 64)
			if err != nil {
				break
			}
			if len(samples) == 0 {
				samples = append(samples, []uint64{})
			}
			samples[0] = append(samples[0], n)
		}
	}
	if len(samples) == 0 {
		samples = [][]uint64{
			[]uint64{8, 24},
			[]uint64{26, 39},
			[]uint64{4, 10},
		}
	}
	for _, v := range samples {
		fmt.Printf("Input: m = %d, n = %d\nOutput: %t\n\n", v[0], v[1], gcdEuclidean(v[0], v[1])%2 == 0)
	}
}

func gcdEuclidean(a, b uint64) uint64 {
	for a != b {
		if a > b {
			a -= b
		} else {
			b -= a
		}
	}

	return a
}
