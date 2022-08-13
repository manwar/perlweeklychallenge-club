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
		//for j := 0; j <= n-i; j++ {
		/*
			for j := i; j <= n-i; j++ {
				if n-i-j < j {
					break
				}
		*/
		/**/
		for j := i + 1; j <= n-i; j++ {
			if n-i-j <= j {
				break
			}
			/**/
			fmt.Fprintf(w, "%2d, %2d, %2d\n", i, j, n-i-j)
		}
	}
	w.Flush()
}
