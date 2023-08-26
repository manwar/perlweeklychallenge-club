package main

import (
	"fmt"
	"strconv"
)

func senior_citizens(arr []string) int {
	count := 0
	for _, e := range arr {
		len := len(e)
		i, err := strconv.Atoi(e[len-4 : len-2])
		if err != nil {
			return 0
		}
		if i >= 60 {
			count += 1
		}
	}
	return count
}

func main() {
	arr1 := []string{"7868190130M7522",
		"5303914400F9211",
		"9273338290F4010"}
	arr2 := []string{"1313579440F2036", "2921522980M5644"}
	fmt.Println(senior_citizens(arr1))
	fmt.Println(senior_citizens(arr2))
}
