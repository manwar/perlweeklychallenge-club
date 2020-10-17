/*
 * test with : go run ch-1.go 12 8
 * Ref: https://www.admfactory.com/convert-string-to-int-golang/
 *      https://stackoverflow.com/questions/13247644/tostring-function-in-go
 */

/* Comment:
 * I cannot see why go is popular... T.T
 */

package main

import (
	"os"
	"fmt"
	"strings"
	"strconv"
)

func usage() {
	fmt.Println( "Usage: go run ch-1.go <natural num> <natural num>" )
}


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

type Nat int
func (n Nat) String() string {
	return fmt.Sprintf("%d", n)
}

func gcd(m int, n int) int { // a not bad gcd implementation
	var sm, bg int

	if m == n {
		return(m)
	} else if m < n {
		sm, bg = m, n
	} else {
		sm, bg = n, m
	}

	if bg % sm == 0 {
		return(sm)
	}

	for i := sm-1; i > 0; i-- {
		if bg % i == 0 && sm % i == 0  {
			return(i)
		}
	}
	// cannot reach here but have to mention
	return(1)
}

func commonDivisors (a int, b int) []int {
	var result []int
	gcd := gcd(a,b)

	for i := 1; i <= gcd; i++ {
		if gcd % i == 0 {
			result = append(result, i);
		}
	}
	return result
}

func main() {
	if len(os.Args[1:]) != 2 {
		usage();
		os.Exit(1);
	}

	var N []Nat
	all_good := true

	for _, str := range os.Args[1:3] {
		if MaybeNat(str).isNatural() {
			N = append(N, MaybeNat(str).Nat())
		} else {
			all_good = false
			break
		}
	}

	if ! all_good {
		usage();
		os.Exit(2);
	}

	cvs := commonDivisors(int(N[0]), int(N[1]))

	var S []string
	for _, n := range(cvs) {
		S = append(S, Nat(n).String())
	}

	fmt.Println( "(" + strings.Join(S, ", ") + ")" )
}
