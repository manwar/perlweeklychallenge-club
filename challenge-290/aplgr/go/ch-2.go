package main

import (
	"unicode"
)

func luhnCheck(str string) bool {
	sum := 0
	payload := 0
	digits := []int{}

	for _, char := range str {
		if unicode.IsDigit(char) {
			digit := int(char - '0')
			digits = append(digits, digit)
		}
	}

	if len(digits) == 0 {
		return false
	}

	payload = digits[len(digits)-1]

	for i := 0; i < len(digits)-1; i++ {
		digit := digits[i]
		if (len(digits)-2-i)%2 == 0 {
			digit *= 2
			if digit > 9 {
				digit -= 9
			}
		}
		sum += digit
	}

	checkDigit := (10 - (sum % 10)) % 10

	return payload == checkDigit
}
