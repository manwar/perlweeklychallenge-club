/* https://theweeklychallenge.org/blog/perl-weekly-challenge-139/

TASK #2 › Long Primes

Submitted by: [42]Mohammad S Anwar
     __________________________________________________________________

   Write a script to generate first 5 Long Primes.

     A prime number (p) is called Long Prime if (1/p) has an infinite
     decimal expansion repeating every (p-1) digits.

Example

7 is a long prime since 1/7 = 0.142857142857...
The repeating part (142857) size is 6 i.e. one less than the prime number 7.

Also 17 is a long prime since 1/17 = 0.05882352941176470588235294117647...
The repeating part (0588235294117647) size is 16 i.e. one less than the prime nu
mber 17.

Another example, 2 is not a long prime as 1/2 = 0.5.
There is no repeating part in this case.

*/
package main

import (
	"fmt"
	"log"
	"math/big"
	"os"
	"strconv"
	"strings"

	"github.com/jbarham/primegen"
)

func main() {
	var n uint = 5
	fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d", &n)
	pg := primegen.New()
	pg.SkipTo(3)
	var p uint64
	var strb strings.Builder
	k := n
	for k > 0 {
		p = pg.Next()
		if 10%p == 0 {
			continue
		}
		b, ok := new(big.Int).SetString(fmt.Sprintf("1%0[1]*d", p-1, 0), 10)
		if !ok {
			log.Fatal("failed on SetString()")
		}
		b.Sub(b, big.NewInt(1))
		str := fmt.Sprintf("%0[1]*v", p-1, b.Div(b, big.NewInt(int64(p))).String())
		l := len(str)
		if str[:l/2] == str[l/2:l] {
			goto skip
		}
		for i := 4; i <= l; i += 2 {
			if str[:i/2] == str[i/2:i] {
				goto skip
			}
		}
		//fmt.Printf("%d => 0.%s\n", p, str)
		strb.WriteString(", " + strconv.FormatUint(p, 10))
		k--
	skip:
	}
	res := strb.String()[2:]
	fmt.Println(res)
	/*
		ans := "7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131, 149, 167, 179, 181, 193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419, 433, 461, 487, 491, 499, 503, 509, 541, 571, 577, 593, 619, 647, 659, 701, 709, 727, 743, 811, 821, 823, 857, 863, 887, 937, 941, 953, 971, 977, 983"
		fmt.Printf("it is %t that first %d long prime(s) = %s\n", res == strings.Join(strings.Split(ans, ", ")[:n], ", "), n, res)
	*/
}
