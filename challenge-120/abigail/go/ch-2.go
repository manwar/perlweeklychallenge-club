package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
)

var DIFF_PER_MINUTE =  11;
var MIN_PER_HOUR    =  60;
var FULL_CIRCLE     = 720;

func main () {
    var hours, minutes int;
    for {
        var n, err = fmt . Scanf ("%d:%d", &hours, &minutes)
        if (err != nil || n != 2) {
            break;
        }
        var angle = (DIFF_PER_MINUTE * (hours * MIN_PER_HOUR + minutes)) %
                                                FULL_CIRCLE;
        if (2 * angle >= FULL_CIRCLE) {
            angle = FULL_CIRCLE - angle;
        }

        fmt . Print (angle / 2);
        if (angle % 2 == 1) {
            fmt . Print (".5")
        }
        fmt . Print ("\n")
    }
}
