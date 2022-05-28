/*
Write a script to print all possible series of 3 positive numbers, where in each series at least one of the number is even and sum of the three numbers is always 12. For example, 3,4,5.
*/
// (odd + odd) + odd => (even) + odd => odd, thus three numbers that sum to an even number cannot be all odd, no need to care about the even number
// Assume numbers in series can be duplicated and unordered as none of there contraints are mentioned
package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	w := bufio.NewWriter(os.Stdout)
	n := 12
	for i := 0; i <= n; i++ {
		for j := 0; j <= 12-i; j++ {
			fmt.Fprintf(w, "%d, %d, %d\n", i, j, 12-i-j)
		}
	}
	w.Flush()
}
