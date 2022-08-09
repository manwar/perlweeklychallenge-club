package main

import (
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"

	"github.com/jbarham/primegen"
)

func main() {
	var count uint = 20
	fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d", &count)
	var b strings.Builder
	pg := primegen.New()
	var skipTo uint64 = 100
	pg.SkipTo(skipTo)
	skipLim := skipTo * 10
	var n uint64
	for count > 0 {
		n = pg.Next()
		if n >= skipLim {
			skipTo *= 100
			pg.SkipTo(skipTo)
			skipLim = skipTo * 10
		}
		if isValid(makeDigits(n)) {
			b.WriteString(", " + strconv.FormatUint(n, 10))
			count--
		}
	}
	io.WriteString(os.Stdout, b.String()[2:]+"\n")
}

func makeDigits(n uint64) (s []uint64) {
	for n > 0 {
		s = append(s, n%10)
		n /= 10
	}
	return s
}

func isValid(s []uint64) bool {
	l := len(s)
	m := l / 2
	if s[m] != 0 {
		return false
	}
	for i := 0; i < m; i++ {
		if s[i] == 0 || s[i] != s[l-1-i] {
			return false
		}
	}
	return true
}
