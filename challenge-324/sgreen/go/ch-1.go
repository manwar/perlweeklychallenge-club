package main

import (
    "fmt"
    "os"
    "strconv"
)

func twodArray(ints []int, rows, cols int) ([][]int, error) {
    if rows < 1 || cols < 1 {
        return nil, fmt.Errorf("Rows and columns must be greater than 0.")
    }
    if rows*cols != len(ints) {
        return nil, fmt.Errorf("The product of rows and columns must equal the length of the input list.")
    }
    result := make([][]int, rows)
    for i := 0; i < rows; i++ {
        row := make([]int, cols)
        for j := 0; j < cols; j++ {
            row[j] = ints[i*cols+j]
        }
        result[i] = row
    }
    return result, nil
}

func main() {
    if len(os.Args) < 4 {
        fmt.Println("Usage: go run ch-1.go <int1> <int2> ... <rows> <cols>")
        os.Exit(1)
    }
    array := make([]int, len(os.Args)-1)
    for i, arg := range os.Args[1:] {
        n, err := strconv.Atoi(arg)
        if err != nil {
            fmt.Printf("Invalid integer: %s\n", arg)
            os.Exit(1)
        }
        array[i] = n
    }
    rows := array[len(array)-2]
    cols := array[len(array)-1]
    ints := array[:len(array)-2]
    result, err := twodArray(ints, rows, cols)
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
    fmt.Println(result)
}