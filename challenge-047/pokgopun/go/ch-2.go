/* https://theweeklychallenge.org/blog/perl-weekly-challenge-047/
TASK #2
Gapful Number
Write a script to print first 20 Gapful Numbers greater than or equal to 100. Please check out the page for more information about Gapful Numbers.
*/
package main

import (
	"bufio"
	"os"
	"strconv"

	"github.com/pokgopun/go/gapful"
)

func main() {
	n := 20
	w := bufio.NewWriter(os.Stdout)
	for i := 100; i < 500; i++ {
		if gapful.IsGapful(i) {
			w.WriteString(strconv.Itoa(i) + "\n")
			n--
			if n == 0 {
				break
			}
		}
	}
	w.Flush()
}
