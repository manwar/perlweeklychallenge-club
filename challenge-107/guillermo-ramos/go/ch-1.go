package ch107

import "fmt"

func IsSelfDescriptive(n int) bool {
	nStr := fmt.Sprint(n)

	digits := make(map[rune]int)
	for _, r := range nStr {
		digits[r] += 1
	}

	for i, r := range nStr {
		digit := int(r) - '0'
		appears := digits[rune('0'+i)]
		if digit != appears {
			return false
		}
	}
	return true
}

func SelfDescriptiveNumbers(count int) []int {
	res := make([]int, 0, count)
	for i := 0; count > 0; i++ {
		if IsSelfDescriptive(i) {
			res = append(res, i)
			count--
		}
	}
	return res
}
