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

func dist (x1 int, y1 int, x2 int, y2 int) int {
    return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
}

func main () {
    var x1, y1, x2, y2, x3, y3, x4, y4 int;
    for {
        var n, err = fmt . Scanf ("%d %d %d %d %d %d %d %d",
                                   &x1, &y1, &x2, &y2, &x3, &y3, &x4, &y4);
        if (err != nil || n != 8) {
            break;
        }

        if (dist (x1, y1, x2, y2) == dist (x2, y2, x3, y3) &&
            dist (x2, y2, x3, y3) == dist (x3, y3, x4, y4) &&
            dist (x3, y3, x4, y4) == dist (x4, y4, x1, y1) &&
            dist (x1, y1, x3, y3) == dist (x2, y2, x4, y4)) {
            fmt . Printf ("%d\n", 1);
        } else { // Seriously, go, else needs to be cuddled?
            fmt . Printf ("%d\n", 0);
        }
    }
}
