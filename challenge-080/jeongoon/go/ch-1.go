package main

/* Ref:
https://tour.golang.org/flowcontrol/1
https://www.davidkaya.com/sets-in-golang/
https://golangdocs.com/converting-string-to-integer-in-golang
*/

/* test with:
go run ch-1.go -2 3 5 2 1
# > 4
*/

import (
	"fmt"
	"os"
	"strconv"
)

var exists = struct{}{}

type intSet struct {
	m map[int]struct{}
}

func NewIntSet() *intSet {
	s := &intSet{}
	s.m = make(map[int]struct{})
	return s
}

func (s *intSet) Add(value int) {
	s.m[value] = exists
}

func (s *intSet) Remove(value int) {
	delete(s.m, value)
}

func (s *intSet) Contains(value int) bool {
	_, c := s.m[value]
	return c
}

func main() {
	set := NewIntSet()
	max := 0
	args := os.Args[1:] // ignore programme name

	for _, it := range args {
		int_val, err := strconv.Atoi( it )
		if err != nil {
			fmt.Fprint( os.Stderr, err )
			fmt.Fprintln( os.Stderr, ": skipped" )
		}
		if int_val < 0 {
			fmt.Fprintln( os.Stderr,
				"negative values are unnecessary: skipped" )
		} else {
			set.Add( int_val )
			if max < int_val {
				max = int_val
			}
		}
	}
	max++;

	for maybe_missing := 1; maybe_missing <= max; maybe_missing++ {
		if ! set.Contains( maybe_missing ) {
			fmt.Println( maybe_missing )
			break
		}
	}
}
