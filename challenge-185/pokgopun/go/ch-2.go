package main

import (
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"
)

const mask = byte('x')

func main() {
	var (
		b strings.Builder
		s []string
	)
	if len(os.Args) < 2 {
		DefaultArgs()
	}
	for _, v := range os.Args[1:] {
		b.Reset()
		b.Write(Mask([]byte(v), mask, 4))
		s = append(s, b.String())
	}
	fmt.Printf("Input: %q\nOutput: %q\n\n", os.Args[1:], s)
}

func Mask(bytes []byte, mask byte, count uint) []byte {
	if count == 0 {
		count = uint(len(bytes))
	}
	for i, v := range bytes {
		// 0-9 => 48-57, a-z => 97-122
		if (v >= 48 && v <= 57) || (v >= 97 && v <= 122) {
			bytes[i] = mask
			count--
			if count == 0 {
				break
			}
		}
	}
	return bytes
}

func DefaultArgs() {
	rand.Seed(time.Now().UnixNano())
	switch rand.Intn(2) {
	case 0:
		os.Args = append(os.Args, "ab-cde-123", "123.abc.420", "3abc-0010.xy")
	case 1:
		os.Args = append(os.Args, "1234567.a", "a-1234-bc", "a.b.c.d.e.f")
	}
}
