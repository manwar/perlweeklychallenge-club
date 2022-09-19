/* https://theweeklychallenge.org/blog/perl-weekly-challenge-140/
TASK #2 › Multiplication Table
Submitted by: Mohammad S Anwar
You are given 3 positive integers, $i, $j and $k.

Write a script to print the $kth element in the sorted multiplication table of $i and $j.

Example 1
Input: $i = 2; $j = 3; $k = 4
Output: 3

Since the multiplication of 2 x 3 is as below:

    1 2 3
    2 4 6

The sorted multiplication table:

    1 2 2 3 4 6

Now the 4th element in the table is "3".
Example 2
Input: $i = 3; $j = 3; $k = 6
Output: 4

Since the multiplication of 3 x 3 is as below:

    1 2 3
    2 4 6
    3 6 9

The sorted multiplication table:

    1 2 2 3 3 4 6 6 9

Now the 6th element in the table is "4".
*/
package main

import (
	"errors"
	"fmt"
	"log"
	"os"
	"sort"
	"strings"
)

func main() {
	s := make([][3]int, 1)
	i, j, k := &s[0][0], &s[0][1], &s[0][2]
	_, err := fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d %d %d", i, j, k)
	if err != nil {
		s = [][3]int{
			[3]int{2, 3, 4},
			[3]int{3, 3, 6},
		}
	}
	for _, v := range s {
		mt, err := NewMulTab(v[0], v[1], v[2])
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(mt)
	}
}

type mulTab struct {
	i, j, k, kth int
	desc         string
}

func NewMulTab(i, j, k int) (mulTab, error) {
	if i < 1 || j < 1 || k > i*j {
		return mulTab{}, errors.New("i, j must be greater than 1 while k must not be greater than i*j")
	}
	s := []int{}
	var (
		v    int
		desc string
	)
	desc += fmt.Sprintf(`
Since the multiplication of %d x %d is as below:

`, i, j)
	for x := 1; x <= i; x++ {
		for y := 1; y <= j; y++ {
			v = x * y
			desc += fmt.Sprint(" ", v)
			s = append(s, v)
		}
		desc += "\n"
	}
	sort.Ints(s)
	desc += fmt.Sprintf(`
The sorted multiplication table:

%v

Now element#%d in the table is "%d".
`, s, k, s[k-1])
	return mulTab{i, j, k, s[k-1], desc}, nil
}
func (mt mulTab) String() string {
	return fmt.Sprintf("Input: i = %d, j = %d, k = %d\nOutput: %d\n", mt.i, mt.j, mt.k, mt.kth) + mt.desc
}
