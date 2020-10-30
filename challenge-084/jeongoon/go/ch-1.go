package main

import (
	"os"
	"fmt"
	"strings"
)

func usage() {
	fmt.Println( "Usage: go run ch-1.go <an integer>" )
}

type Int32Str string;

func (nStr Int32Str) Abs() Int32Str {
	switch nStr[0] {
	case '+':
		return nStr[1:]
	case '-':
		return nStr[1:]
	default:
		return nStr
	}
}

func (nStr Int32Str) LimitAbs() Int32Str{
	var lim int
	switch nStr[0] {
	case '-':
		lim = 1 << 31
	default:
		lim = 1 << 31 - 1
	}
	return Int32Str( fmt.Sprintf("%d", lim) )
}

func (nStr Int32Str) IsFit(limStr Int32Str) bool {
	if limStr == "" {
		limStr = nStr.LimitAbs()
	}
	nAbs := nStr.Abs()
	nLen := len(nAbs)
	lLen := len(limStr)
	if nLen < lLen {
		return true
	} else if nLen > lLen {
		return false
	} else {
		switch strings.Compare( string(nAbs), string(limStr) ) {
		case  -1:
			return false
		default:
			return true
		}
	}

}

// credit: https://www.geeksforgeeks.org/how-to-reverse-a-string-in-golang/
func (nStr Int32Str) Reverse() Int32Str {
	var nWithoutSign Int32Str
	sign := ""

	switch nStr[0] {
	case '+':
		nWithoutSign = nStr[1:]
	case '-':
		nWithoutSign = nStr[1:]
		sign = "-"
	default:
		nWithoutSign = nStr
	}

	rns := []rune(string(nWithoutSign))
	for i, j := 0, len(rns) -1; i < j; i, j = i+1, j-1 {
		rns[i], rns[j] = rns[j], rns[i]
	}

	// remove zeroes at the beginning

	return Int32Str( sign + string(rns) )
}

func main() {
	if len(os.Args[1:]) != 1 {
		usage()
		os.Exit(1)
	}

	var nstring = os.Args[1]

	reversed := Int32Str(nstring).Reverse()
	limit    := Int32Str(nstring).LimitAbs()

	fmt.Fprintln( os.Stderr, "Input:      ", nstring )
	fmt.Fprintln( os.Stderr, "Reversed:   ", reversed )
	fmt.Fprintln( os.Stderr, "Limit(abs): ", limit )
	fmt.Fprint(   os.Stderr, "Output:     " )
	if ( reversed.IsFit(limit) ) {
		fmt.Print( reversed )
		fmt.Fprint( os.Stderr, " (good)" )

	} else {
		fmt.Print( "0" )
		fmt.Fprint( os.Stderr, " (overflow)" )
	}
	fmt.Println( "" )

	os.Exit(0)
}
