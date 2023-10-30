package main

import (
	"fmt"
	"strings"
)

func acronym(arr []string, check string) bool {
	var sb strings.Builder
	for _, v := range arr {
		sb.WriteString(strings.ToLower(string(v[0])))
	}
	return strings.Compare(sb.String(), check) == 0
}

func main() {
	arr1 := []string{"Perl", "Python", "Pascal"}
	arr2 := []string{"Perl", "Raku"}
	arr3 := []string{"Oracle", "Awk", "C"}
	fmt.Println(acronym(arr1, "ppp"))
	fmt.Println(acronym(arr2, "rp"))
	fmt.Println(acronym(arr3, "oac"))
}
