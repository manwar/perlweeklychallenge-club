package main

import (
    "fmt"
    "strconv"
)

func main() {
    N := 4
    grayCode := []string{"0", "1"}

    for i := 2; i <= N; i++ {
        revGrayCode := make([]string, len(grayCode))
        copy(revGrayCode, grayCode)
        for j := 0; j < len(revGrayCode)/2; j++ {
            revGrayCode[j], revGrayCode[len(revGrayCode)-j-1] = revGrayCode[len(revGrayCode)-j-1], revGrayCode[j]
        }
        for j := 0; j < len(grayCode); j++ {
            grayCode[j] = "0" + grayCode[j]
        }
        for j := 0; j < len(revGrayCode); j++ {
            revGrayCode[j] = "1" + revGrayCode[j]
        }
        grayCode = append(grayCode, revGrayCode...)
    }

    for _, x := range grayCode {
        n, _ := strconv.ParseInt(x, 2, 64)
        fmt.Print(n, " ")
    }
    fmt.Println()
}
