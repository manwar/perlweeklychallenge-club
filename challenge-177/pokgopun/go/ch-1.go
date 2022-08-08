package main

import (
	"fmt"
	"log"
	"os"
)

func main() {
	tStr := "0317598642709215486342068713591750983426612304597836742095815869720134894536201794386172052581436790"
	guide := "please provide a positive number as an argument"
	var n uint = 5724
	if len(os.Args) < 2 {
		log.Fatal(guide)
	}
	_, err := fmt.Sscanf(os.Args[1], "%d", &n)
	if err != nil {
		log.Fatal(guide)
	}
	var r byte
	for _, v := range []byte(os.Args[1]) {
		//fmt.Println("r =", r)
		v -= 48
		r = tStr[r*10+v] - 48
	}
	fmt.Printf("Input: n = %s\nOutput: %t\n", os.Args[1], r == 0)
}
