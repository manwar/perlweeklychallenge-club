// Write a script to generate the check digit of given ISBN-13 code. Please refer wikipedia for more information.
package main

import (
	"errors"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	isbns := []string{"978-0-306-40615-7"}
	if len(os.Args) > 1 {
		isbns = os.Args[1:]
	}
	for _, v := range isbns {
		r, err := checkDigit(extractDigits(v))
		var res string
		if err != nil {
			res = "not available due to " + fmt.Sprint(err)
		} else {
			res = strconv.Itoa(r)
		}
		fmt.Printf("ISBN-13 check digit for %q is %s\n", v, res)
	}
}

func extractDigits(str string) (s []int, n int) {
	str = regexp.MustCompile(`\D`).ReplaceAllLiteralString(str, "")
	if len(str) > 0 {
		for _, v := range str {
			s = append(s, int(v-48))
		}
		return s, len(s)
	}
	return []int{}, 0
}

func checkDigit(s []int, n int) (r int, err error) {
	if n < 12 || n > 13 {
		return 0, errors.New("invalid input")
	}
	for i := 0; i < 12; i += 2 {
		r += s[i] + 3*s[i+1]
	}
	r %= 10
	r = 10 - r
	if r == 10 {
		r = 0
	}
	return r, nil
}
