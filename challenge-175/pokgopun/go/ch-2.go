/* https://theweeklychallenge.org/blog/perl-weekly-challenge-175/
Task 2: Perfect Totient Numbers
Submitted by: Mohammad S Anwar
Write a script to generate first 20 Perfect Totient Numbers. Please checkout wikipedia page for more informations.


Output

3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
2187, 2199, 3063, 4359, 4375, 5571
*/
package main

import (
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"

	"github.com/pokgopun/go/totient"
)

func main() {
	var count, start uint64 = 20, 3
	fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d %d", &count, &start)
	var b strings.Builder
	for _, v := range totient.New().ListPerfect(start, count) {
		b.WriteString(", " + strconv.FormatUint(v, 10))
	}
	io.WriteString(os.Stdout, (b.String()[2:])+"\n")
}
