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
	"io"
	"os"
	"strconv"
	"strings"

	"github.com/pokgopun/go/totient"
)

func main() {
	var cntdwn uint = 20
	p := totient.New(cntdwn)
	var b strings.Builder
	for i := uint(3); i < 200_000; i += 2 {
		if p.IsPerfect(i) {
			b.WriteString(", " + strconv.FormatUint(uint64(i), 10))
			//fmt.Println(i)
			cntdwn--
		}
		if cntdwn == 0 {
			break
		}
	}
	io.WriteString(os.Stdout, (b.String()[2:])+"\n")
}
