package main

import "fmt"

func check_squares ( p[] int) bool {
    var sum = p[0] + p[1]
    return ( p[1] + p[2] + p[3] == sum &&
        p[3] + p[4] + p[5] == sum &&
        p[5] + p[6] == sum)
}

func main() {
    var in = []int{1, 2, 3, 4, 5, 6, 7}
    var max = len(in) - 1
    var i, j int
    for c := 1; c < 5040; c++ { // 7! = 5040
        i = max - 1
        j = max
        for in[i] > in[i+1] {
            i--
        }
        for in[j] < in[i] {
            j--
        }
        in[i], in[j] = in[j], in[i]
        j = max
        i += 1
        for i < j {
            in[i], in[j] = in[j], in[i]
            i++
            j--
        }
        if check_squares(in) {
            fmt.Println(in)
        }
    }
}
