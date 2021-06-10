package main

import "fmt"

func main() {
    const MAX int = 10
    var tr [MAX][MAX]int
    tr[0][0] = 1
    var results [MAX]int
    for row := 1; row < MAX; row++ {
        tr[row][0] = tr[row-1][row-1]
        results[row] = tr[row][0]
        for i := 1; i <= row; i++ {
            tr[row][i] = tr[row][i-1] + tr[row-1][i-1]
        }
    }
    fmt.Println("The first Bell numbers are: ", results)
}
