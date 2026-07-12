package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    var matrix [] [] int
    N := 0
    r := true
    for row := 0; true; row ++ {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        numbers := strings . Fields (strings . TrimSpace (text))
        if N == 0 {
            N = len (numbers)
            matrix = make ([] [] int, N)
        }
        matrix [row] = make ([] int, N)
        for col, num := range numbers {
            number, _ := strconv . Atoi (num)
            if number < 1 || N < number {
                r = false
            }
            matrix [row] [col] = number
        }
    }

    for i := 0; i < N; i ++ {
        //
        // Create maps 'row' and 'col', which we will use to check
        // we have N different numbers in row i and col i
        //
        row := make (map [int] bool)
        col := make (map [int] bool)

        //
        // Populate the row and col
        //
        for j := 0; j < N; j ++ {
            row [matrix [i] [j]] = true
            col [matrix [j] [i]] = true
        }

        //
        // Check whether the row and column have N different entries
        //
        if len (row) != N || len (col) != N {
            r = false
        }
    }

    if (r) {
        fmt . Println ("true")
    } else {
        fmt . Println ("false")
    }

}
