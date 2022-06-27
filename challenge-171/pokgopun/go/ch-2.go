/* https://theweeklychallenge.org/blog/perl-weekly-challenge-171/
Task 2: First-class Function
Submitted by: Mohammad S Anwar
Create sub compose($f, $g) which takes in two parameters $f and $g as subroutine refs and returns subroutine ref i.e. compose($f, $g)->($x) = $f->($g->($x))


e.g.

$f = (one or more parameters function)
$g = (one or more parameters function)

$h = compose($f, $g)
$f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...
*/
package main

import (
	"fmt"

	"github.com/google/go-cmp/cmp"
)

func main() {
	SquareAfterDigitsum := Compose(Square, Digitsum)
	DigitsumAfterSquare := Compose(Digitsum, Square)
	s := []uint{29, 39, 49}
	fmt.Println("\nExample#1\n")
	fmt.Printf("Square(Digitsum(%v)) equals SquareAfterDigitsum(%[1]v) is %t\n", s, cmp.Diff(Square(Digitsum(s)), SquareAfterDigitsum(s)) == "")
	fmt.Printf("=> Digitsum(%v) = %v -> Square(%[2]v) = %v\n", s, Digitsum(s), Square(Digitsum(s)))
	fmt.Printf("=> SquareAfterDigitsum = Compose(Square, Digitsum) -> SquareAfterDigitsum(%v) = %v\n", s, SquareAfterDigitsum(s))
	fmt.Println("\nExample#2\n")
	fmt.Printf("Digitsum(Square(%v)) equals DigitsumAfterSquare(%[1]v) is %t\n", s, cmp.Diff(Digitsum(Square(s)), DigitsumAfterSquare(s)) == "")
	fmt.Printf("=> Square(%v) = %v -> Digitsum(%[2]v) = %v\n", s, Square(s), Digitsum(Square(s)))
	fmt.Printf("=> DigitsumAfterSquare = Compose(Digitsum, Square) -> DigitsumAfterSquare(%v) = %v\n", s, DigitsumAfterSquare(s))
	fmt.Println("\n")
}
func Compose(f1, f2 func([]uint) []uint) func([]uint) []uint {
	return func(s []uint) []uint {
		return f1(f2(s))
	}
}
func Square(s []uint) (r []uint) {
	r = make([]uint, len(s))
	copy(r, s)
	for i, v := range r {
		r[i] *= v
	}
	return r
}
func Digitsum(s []uint) (r []uint) {
	r = make([]uint, len(s))
	for i, v := range s {
		for v > 0 {
			r[i] += v % 10
			v /= 10
		}
	}
	return r
}
