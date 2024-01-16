package main

import (
	"fmt"
	"strconv"
)

func isNumeric(s string) bool {
	_, err := strconv.ParseFloat(s, 64)
	return err == nil
}

func alphanumericStringValue(arr []string) int {
	max := 0
	for _, v := range arr {
		n := 0
		if isNumeric(v) {
			n, _ = strconv.Atoi(v)
		} else {
			n = len(v)
		}
		if n > max {
			max = n
		}
	}
	return max
}

func main() {
	arr1 := []string{"perl", "2", "000", "python", "r4ku"}
	arr2 := []string{"001", "1", "000", "0001"}
	fmt.Println(alphanumericStringValue(arr1))
	fmt.Println(alphanumericStringValue(arr2))
}
