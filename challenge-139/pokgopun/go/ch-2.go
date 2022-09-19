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
	"math"
	"math/big"
	"os"
	"sort"
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
		if isRepeating(str) {
			continue
		}
		strb.WriteString(", " + strconv.FormatUint(p, 10))
		k--
	}
	res := strb.String()[2:]
	fmt.Println(res)
	/*
		ans := "7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131, 149, 167, 179, 181, 193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419, 433, 461, 487, 491, 499, 503, 509, 541, 571, 577, 593, 619, 647, 659, 701, 709, 727, 743, 811, 821, 823, 857, 863, 887, 937, 941, 953, 971, 977, 983"
		fmt.Printf("it is %t that first %d long prime(s) = %s\n", res == strings.Join(strings.Split(ans, ", ")[:n], ", "), n, res)
	*/
}

func isRepeating(str string) bool {
	l := uint64(len(str))
	if l <= 1 {
		return false
	}
	s := []uint64{1}
	lim := uint64(math.Sqrt(float64(l)))
	for i := uint64(2); i <= lim; i++ {
		if l%i == 0 {
			s = append(s, i)
			if i*i != l {
				s = append(s, l/i)
			}
		}
	}
	sort.Slice(s, func(i, j int) bool {
		return s[i] > s[j]
	})
	//fmt.Println(s)
	for _, v := range s {
		//fmt.Println("v =", v)
		var prev, curr string
		var count uint64
		for i := v; i <= l; i += v {
			//fmt.Println("i =", i)
			curr = str[i-v : i]
			if curr != prev {
				count++
			}
			//fmt.Println(curr, count)
			if count > 1 {
				//fmt.Println("!!! no repeating for", v, "chars")
				goto skip
			}
			prev = curr
		}
		return true
	skip:
	}
	return false
}
