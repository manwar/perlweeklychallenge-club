package main

//  functions come from [wiki](https://en.wikipedia.org/wiki/Julian_day#Julian_day_number_calculation)
//  translated from [abigail's Perl blog post](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-132-1.html)

import (
	"fmt"
	"log"
)

// Gregorian to Julian calendar converter
func g2j(Y, M, D int64) int64 {
	return ((1461*(Y+4800+(M-14)/12))/4 +
		(367*(M-2-12*((M-14)/12)))/12 -
		(3*((Y+4900+(M-14)/12)/100))/4 + D - 32075)
}

// Julian to Gregorian calendar converter
func j2g(jd int64) []int64 {
	e := 4*(jd+1401+(((4*jd+274277)/146097)*3)/4-38) + 3
	D := ((5*((e%1461)/4)+2)%153)/5 + 1
	M := (((5*((e%1461)/4)+2)/153 + 2) % 12) + 1
	Y := (e / 1461) - 4716 + (12+2-M)/12
	return []int64{Y, M, D}
}

var today = []uint{2021, 9, 22} // using this date for testing

func main() {
	//read in the input date
	var Y, M, D int64
	fmt.Println("input yr, mon, and date on each line") // Question to the user
	if _, err := fmt.Scan(&Y, &M, &D); err != nil {
		log.Println(err)
	}

	today_y := int64(today[0])
	today_m := int64(today[1])
	today_d := int64(today[2])

	julian_2day := g2j(today_y, today_m, today_d)
	julian_then := g2j(Y, M, D)
	then := j2g(2*julian_then - julian_2day)
	now := j2g(2*julian_2day - julian_then)
	fmt.Printf("%04d/%02d/%02d => %04d/%02d/%02d\n", then[0], then[1], then[2], now[0], now[1], now[2])
}
