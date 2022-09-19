package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func main() {
	n := 9801
	fmt.Sscanf(strings.Join(os.Args[1:], " "), "%d", &n)
	fmt.Printf("Input: n = %d\nOutput: %t\n", n, isSplitNum(n))
}
func isSplitNum(n int) bool {
	sqrt := int(math.Sqrt(float64(n)))
	if n != sqrt*sqrt {
		return false
	}
	nStr := strconv.Itoa(n)
	var res string
	splits := strings.TrimSuffix(numSplit(nStr, "", &res), " "+nStr)
	for _, v := range strings.Split(splits, " ") {
		if sumSplit(v) == sqrt {
			//fmt.Printf("Since, sqrt(%d) = %d = %s\n", n, sqrt, v)
			return true
		}
	}
	return false
}

func numSplit(s, t string, res *string) string {
	l := len(s)
	if l > 0 {
		for i := 0; i < l; i++ {
			numSplit(s[i+1:], strings.Join([]string{t, s[:i+1]}, "+"), res)
		}
	} else {
		*res += " " + t[1:]
		return ""
	}
	return (*res)[1:]
}

func sumSplit(str string) (sum int) {
	for _, v := range strings.Split(str, "+") {
		n, _ := strconv.Atoi(v)
		sum += n
	}
	return sum
}
