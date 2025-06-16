package main

import (
	"fmt"
	"log"
	"time"
)

func dayOfTheYear(str string) int {
	t, err := time.Parse(time.DateOnly, str)
	if err != nil {
		log.Fatal("Wrong date string")
	}
	return t.YearDay()
}

func main() {
	fmt.Println(dayOfTheYear("2025-02-02"))
	fmt.Println(dayOfTheYear("2025-04-10"))
	fmt.Println(dayOfTheYear("2025-09-07"))
}
