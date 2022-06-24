/*
TASK #2 › Like Numbers
Submitted by: Mohammad S Anwar
You are given positive integers, $m and $n.

Write a script to find total count of integers created using the digits of $m which is also divisible by $n.

Repeating of digits are not allowed. Order/Sequence of digits can’t be altered. You are only allowed to use (n-1) digits at the most. For example, 432 is not acceptable integer created using the digits of 1234. Also for 1234, you can only have integers having no more than three digits.

Example 1:
Input: $m = 1234, $n = 2
Output: 9

Possible integers created using the digits of 1234 are:
1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.

There are 9 integers divisible by 2 such as:
2, 4, 12, 14, 24, 34, 124, 134 and 234.
Example 2:
Input: $m = 768, $n = 4
Output: 3

Possible integers created using the digits of 768 are:
7, 6, 8, 76, 78 and 68.

There are 3 integers divisible by 4 such as:
8, 76 and 68.
*/
package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/pokgopun/go/likenums"
)

func main() {
	s := make([][2]uint, 1)
	if len(os.Args) > 2 {
		_, err := fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d %d", &s[0][0], &s[0][1])
		if err != nil {
			log.Fatal(err)
		}
	} else {
		s[0] = [2]uint{1234, 2}
		s = append(s, [2]uint{768, 4})
	}
	for _, v := range s {
		c, err := likenums.Count(v[0], v[1])
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("Input: m = %d, n = %d\nOutput: %d\n\n", v[0], v[1], c)
	}
}
