package main

import (
	"fmt"
	"log"
	"math"
	"math/cmplx"
	"os"
	"strconv"
)

var (
	p = []float64{
		0.99999999999980993,
		676.5203681218851,
		-1259.1392167224028,
		771.32342877765313,
		-176.61502916214059,
		12.507343278686905,
		-0.13857109526572012,
		9.9843695780195716e-6,
		1.5056327351493116e-7,
	}
	g float64 = 7
)

func gamma(z complex128) complex128 {
	if real(z) < 0.5 {
		return math.Pi / (cmplx.Sin(math.Pi*z) * gamma(1-z))
	}
	t := complex(real(z)+g-0.5, imag(z))
	x := complex(p[0], 0)
	for i, v := range p[1:] {
		x += complex(v, 0) / complex(real(z)+float64(i), imag(z))
	}
	return math.Sqrt2 * math.SqrtPi * cmplx.Pow(t, z-0.5) * cmplx.Exp(-t) * x
}

func main() {
	var c []complex128
	if len(os.Args) > 1 {
		for _, v := range os.Args[1:] {
			n, err := strconv.ParseComplex(v, 128)
			if err != nil {
				log.Fatal(err)
			}
			c = append(c, n)
		}
	} else {
		c = []complex128{1, 2, 3, 4, 5, 6, 7, 0.5, 1.5, -0.5, 1 - 1i, 0.5 - 0.5i, 5 + 3i, 5 - 3i}
	}
	for _, v := range c {
		fmt.Printf("gamma%v=%v\n", v, gamma(v))
	}
}
