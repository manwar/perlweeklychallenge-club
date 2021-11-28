package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
)

func g2j (Y int, M int, D int) int {
    return ((1461 * (Y + 4800  +  (M - 14) / 12))  /   4   +
            (367 * (M - 2 - 12 * ((M - 14) / 12))) /  12   -
            (3 * ((Y + 4900    +  (M - 14) / 12)   / 100)) / 4 + D - 32075)
}

func j2g (J int) (int, int, int) {
    e := 4 * (J + 1401 + (((4 * J + 274277) / 146097) * 3) / 4 - 38) + 3
    D :=  ((5 * ((e % 1461) / 4) + 2) % 153) / 5 + 1
    M := (((5 * ((e % 1461) / 4) + 2) / 153 + 2) % 12) + 1
    Y :=         (e / 1461) - 4716 + (12 + 2 - M) / 12
    return Y, M, D
}

func main () {
    julian_today := g2j (2021, 9, 22)
    var Y, M, D int
    for n, err := fmt . Scanf ("%d/%d/%d", &Y, &M, &D); n == 3 && err == nil
        n, err  = fmt . Scanf ("%d/%d/%d", &Y, &M, &D) {
        julian_then := g2j (Y, M, D)
        Y1, M1, D1  := j2g (2 * julian_then  - julian_today)
        Y2, M2, D2  := j2g (2 * julian_today - julian_then)
        fmt . Printf ("%04d/%02d/%02d, %04d/%02d/%02d\n",
                      Y1, M1, D1, Y2, M2, D2);

    }
}
