package main

import (
	"fmt"
	"strings"
)

func bAfterA(str string) bool {
	i := strings.Index(str,"b")
	return i != -1 && strings.LastIndex(str,"a") <= i
}

func main(){
	fmt.Println(bAfterA("aabb"))
	fmt.Println(bAfterA("abab"))
	fmt.Println(bAfterA("aaa"))
	fmt.Println(bAfterA("bbb"))
}
