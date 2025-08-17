package main

import (
    "encoding/json"
    "fmt"
    "os"
    "math"
)

func nearest_valid_point(x int, y int, points [][2]int) (int, error) {
    nearest_index := -1
    distance := math.MaxInt
    for i, point := range points {
        var this_distance int
        if point[0] == x {
            this_distance = y - point[1]
        } else if point[1] == y {
            this_distance = x - point[0]
        } else {
            continue
        }
        if this_distance < 0 {
            this_distance = -this_distance
        }
        if this_distance < distance {
            nearest_index = i
            distance = this_distance
        }
    }
    return nearest_index, nil
}

func main() {
    errors := false
	for _, json_inputs := range os.Args[1:] {
        var inputs struct { X int; Y int; Points [][2]int }
        err := json.Unmarshal([]byte(json_inputs), &inputs)
        if err != nil {
            fmt.Printf("%-30s -> ERROR %v\n", json_inputs, err)
            errors = true
        } else {
            result, err := nearest_valid_point(inputs.X, inputs.Y, inputs.Points)
            if err != nil {
                fmt.Printf("%-30s -> ERROR %v\n", json_inputs, err)
                errors = true
            } else {
                fmt.Printf("%-30s -> %v\n", json_inputs, result)
            }
        }
	}
    if errors {
        fmt.Printf("Expected arguments like '{\"x\":3,\"y\":4,\"points\":[[1, 2],[3, 1], [2, 4], [2, 3]]}'\n")
    }
}
