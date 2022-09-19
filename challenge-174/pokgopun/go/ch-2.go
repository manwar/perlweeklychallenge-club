/* https://theweeklychallenge.org/blog/perl-weekly-challenge-174/
Task 2: Permutation Ranking
Submitted by: Mohammad S Anwar
You are given a list of integers with no duplicates, e.g. [0, 1, 2].

Write two functions, permutation2rank() which will take the list and determine its rank (starting at 0) in the set of possible permutations arranged in lexicographic order, and rank2permutation() which will take the list and a rank number and produce just that permutation.

Please checkout this post for more informations and algorithm.

Given the list [0, 1, 2] the ordered permutations are:

0: [0, 1, 2]
1: [0, 2, 1]
2: [1, 0, 2]
3: [1, 2, 0]
4: [2, 0, 1]
5: [2, 1, 0]
and therefore:

permutation2rank([1, 0, 2]) = 2

rank2permutation([0, 1, 2], 1) = [0, 2, 1]
*/
package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	w := bufio.NewWriter(os.Stdout)
	for i, v := range permutation(3) {
		w.WriteString(fmt.Sprintf("%d: %v\n\n", i, v))
	}
	w.WriteString(fmt.Sprintf("permutation2rank(%v) = %d\n\n", rank2permutation(3, 2), permutation2rank(rank2permutation(3, 2))))
	w.WriteString(fmt.Sprintf("rank2permutation(%v, %d) = %v\n\n", rank2permutation(3, 0), 1, rank2permutation(3, 1)))
	w.Flush()
}

func permutation(n uint) [][]uint {
	fact := factorial(n)
	s := make([][]uint, fact)
	for r := uint(0); r < fact; r++ {
		s[r] = rank2permutation(n, r)
	}
	return s
}

func permutation2rank(p []uint) uint {
	n := uint(len(p))
	fact := factorial(n - 1)
	var r uint = 0
	digits := make([]uint, n)
	for i := uint(0); i < n; i++ {
		digits[i] = i
	}
	var q uint
	for i := uint(0); i < n-1; i++ {
		q = 0
		for digits[q] != p[i] {
			q++
		}
		r += fact * q
		digits = append(digits[:q], digits[q+1:]...)
		fact /= n - 1 - i
	}
	return r
}

func rank2permutation(n, r uint) []uint {
	fact := factorial(n - 1)
	if r > fact*n-1 {
		return []uint{}
	}
	digits := make([]uint, uint(n))
	for i := uint(0); i < n; i++ {
		digits[i] = i
	}
	p := []uint{}
	var q uint
	for i := uint(0); i < n; i++ {
		q = r / fact
		r %= fact
		p = append(p, digits[q])
		digits = append(digits[:q], digits[q+1:]...)
		if i != n-1 {
			fact /= n - 1 - i
		}
	}
	return p
}

func factorial(n uint) uint {
	if n == 0 {
		return 1
	}
	return n * factorial(n-1)
}
