package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
)

func main () {
    var x1, y1, x2, y2, x3, y3, x4, y4, e1, e2, e3, e4, d1, d2 int;
    for {
        var n, err = fmt . Scanf ("%d %d %d %d %d %d %d %d",
                                   &x1, &y1, &x2, &y2, &x3, &y3, &x4, &y4);
        if (err != nil || n != 8) {
            break;
        }
        e1 = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
        e2 = (x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3);
        e3 = (x3 - x4) * (x3 - x4) + (y3 - y4) * (y3 - y4);
        e4 = (x4 - x1) * (x4 - x1) + (y4 - y1) * (y4 - y1);
        d1 = (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
        d2 = (x2 - x4) * (x2 - x4) + (y2 - y4) * (y2 - y4);

        if (e1 == e2 && e2 == e3 && e3 == e4 && d1 == d2) {
            fmt . Printf ("%d\n", 1);
        } else { // Seriously, go, else needs to be cuddled?
            fmt . Printf ("%d\n", 0);
        }
    }
}
