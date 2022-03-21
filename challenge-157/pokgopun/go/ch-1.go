package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
)

func main() {
	var sos [][]float64
	if len(os.Args) > 1 {
		if len(os.Args) > 2 {
			var s []float64
			for _, v := range os.Args[1:] {
				i, err := strconv.Atoi(v)
				if err != nil {
					log.Fatal(err)
				}
				s = append(s, float64(i))
			}
			sos = append(sos, s)
		} else {
			fmt.Println("Input must be couple integers or more\n\n")
		}
	} else {
		sos = [][]float64{
			[]float64{1, 3, 5, 6, 9},
			[]float64{2, 4, 6, 8, 10},
			[]float64{1, 2, 3, 4, 5},
		}
	}
	for _, s := range sos {
		fmt.Println("Input: @n =", s)
		n := float64(len(s))
		ans := [3]float64{0, 1, 0}
		for _, v := range s {
			ans[0] += v
			ans[1] *= v
			ans[2] += 1 / v
		}
		ans = [3]float64{ans[0] / n, math.Pow(ans[1], 1/n), n / ans[2]}
		fmt.Printf("Output: AM = %.1f, GM = %.1f HM = %.1f\n\n", ans[0], ans[1], ans[2])
	}
}
