package main

import (
	"os"
	"fmt"
	"math"
	"strconv"
)

type MaybeNat string

func (str MaybeNat) Nat() Nat {
	n, err := strconv.Atoi(string(str))
	if err == nil {
		return(Nat(n))
	} else {
		return(Nat(0))
	}
}

func (str MaybeNat) isNatural() bool {
	return(str.Nat() > 0)
}

type Nat int64
func (n Nat) String() string {
	return fmt.Sprintf("%d", n)
}

func maxPowerFactor (n Nat) Nat {
	return Nat(math.Floor(math.Sqrt(float64(n))))
}

func usage () {
	fmt.Println("Usage: go run ch-2.go <a positive integer>" )
}

func main() {
	if len(os.Args[1:]) != 1 {
		usage()
		os.Exit(1)
	}

	if MaybeNat(os.Args[1]).isNatural() == false {
		usage()
		os.Exit(2)
	}

	n := MaybeNat(os.Args[1]).Nat()

	for f := maxPowerFactor(n); f > 1; f-- {
		pow := math.Log( float64(n) ) / math.Log( float64(f) )
		if math.Floor(pow) == pow {
			fmt.Println("1 as " + f.String() +
				"^" + Nat(pow).String() + " = " + n.String())
			os.Exit(0)
		}
	}
	fmt.Println("0")
	os.Exit(3)
}
