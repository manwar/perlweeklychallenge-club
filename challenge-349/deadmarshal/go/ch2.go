package main

import (
	"fmt"
)

func meetingPoint(s string) bool {
	x, y := 0, 0
	for _, c := range s {
		if c == 'U' {
			y++
		} else if c == 'R' {
			x++
		} else if c == 'D' {
			y--
		} else if c == 'L' {
			x--
		}
	}
	return x == 0 && y == 0
}

func main() {
	fmt.Println(meetingPoint("ULD"))
	fmt.Println(meetingPoint("ULDR"))
	fmt.Println(meetingPoint("UUURRRDDD"))
	fmt.Println(meetingPoint("UURRRDDLLL"))
	fmt.Println(meetingPoint("RRUULLDDRRUU"))
}
