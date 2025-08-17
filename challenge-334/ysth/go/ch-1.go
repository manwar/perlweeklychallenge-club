package main

import (
    "encoding/json"
    "errors"
    "fmt"
    "os"
)

func range_sum(ints []int, x int, y int) (int, error) {
    sum := int(0)
    if x < 0 || y < x || y >= len(ints) {
        return sum, errors.New("index out of range")
    }
    for i := x; i <= y; i++ {
        sum += ints[i]
    }
    return sum, nil
}

func main() {
    errors := false
	for _, json_inputs := range os.Args[1:] {
        var inputs struct { Ints []int; X int; Y int }
        err := json.Unmarshal([]byte(json_inputs), &inputs)
        if err != nil {
            fmt.Printf("%-30s -> ERROR %v\n", json_inputs, err)
            errors = true
        } else {
            result, err := range_sum(inputs.Ints, inputs.X, inputs.Y)
            if err != nil {
                fmt.Printf("%-30s -> ERROR %v\n", json_inputs, err)
                errors = true
            } else {
                fmt.Printf("%-30s -> %v\n", json_inputs, result)
            }
        }
	}
    if errors {
        fmt.Printf("Expected arguments like '{\"ints\":[1,2,3],\"x\":0,\"y\":1}'\n")
    }
}
