package main

import (
	"fmt"
	"strings"
)

func formatPhoneNumber(phone string) string {
	phone = strings.ReplaceAll(phone, " ", "")
	phone = strings.ReplaceAll(phone, "-", "")
	n := len(phone)
	res := []string{}
	for i := 0; i < n/3; i++ {
		res = append(res, phone[i*3:i*3+3])
	}
	if n%3 == 1 {
		res[len(res)-1] = res[len(res)-1][:2]
		res = append(res, phone[n-2:])
	} else if n%3 == 2 {
		res = append(res, phone[n-2:])
	}
	return strings.Join(res, "-")
}

func main() {
	fmt.Println(formatPhoneNumber("1-23-45-6"))
	fmt.Println(formatPhoneNumber("1234"))
	fmt.Println(formatPhoneNumber("12 345-6789"))
	fmt.Println(formatPhoneNumber("123 4567"))
	fmt.Println(formatPhoneNumber("123 456-78"))
}
