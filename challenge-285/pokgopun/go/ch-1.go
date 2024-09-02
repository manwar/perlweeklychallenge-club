//# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/
/*#

Task 1: No Connection

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of routes, @routes.

   Write a script to find the destination with no further outgoing
   connection.

Example 1

Input: @routes = (["B","C"], ["D","B"], ["C","A"])
Output: "A"

"D" -> "B" -> "C" -> "A".
"B" -> "C" -> "A".
"C" -> "A".
"A".

Example 2

Input: @routes = (["A","Z"])
Output: "Z"

Task 2: Making Change
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type route struct {
	src, dst string
}

type routes []route

func (rs routes) nc() string {
	m := make(map[string]bool)
	for _, v := range rs {
		m[v.src] = false
		_, ok := m[v.dst]
		if !ok {
			m[v.dst] = true
		}
	}
	for k, v := range m {
		if v {
			return k
		}
	}
	return ""
}

func main() {
	for _, data := range []struct {
		input  routes
		output string
	}{
		{routes{route{"B", "C"}, route{"D", "B"}, route{"C", "A"}}, "A"},
		{routes{route{"A", "Z"}}, "Z"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.nc(), data.output)) // blank if ok, otherwise show the difference
	}
}
