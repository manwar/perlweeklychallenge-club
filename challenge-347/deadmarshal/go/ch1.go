package main

import (
	"fmt"
	"strconv"
	"strings"
)

func formatDate(date string) string {
	s := strings.Split(date, " ")
	day, _ := strconv.Atoi(s[0][:len(s[0])-2])
	months := "JanFebMarAprMayJunJulAugSepOctNovDec"
	month := strings.Index(months, s[1])/3 + 1
	year, _ := strconv.Atoi(s[2])
	return fmt.Sprintf("%d-%02d-%02d", year, month, day)
}

func main() {
	fmt.Println(formatDate("1st Jan 2025"))
	fmt.Println(formatDate("22nd Feb 2025"))
	fmt.Println(formatDate("15th Apr 2025"))
	fmt.Println(formatDate("23rd Oct 2025"))
	fmt.Println(formatDate("31st Dec 2025"))
}
