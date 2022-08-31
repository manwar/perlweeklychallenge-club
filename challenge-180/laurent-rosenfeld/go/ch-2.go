package main

import "fmt"

func main() {
    tests := [2][2][8]int{{{3}, {1, 4, 2, 3, 5}},
                          {{4}, {9, 0, 6, 2, 3, 8, 5}}
                         }
    for j := 0; j < len(tests); j++ {
        i := tests[j][0][0]
        fmt.Printf("i = %d; nums = ", i)
        nums := tests[j][1]
        fmt.Print(nums, "; => ")
        for k := 0; k < len(nums); k++ {
            if nums[k] > i {
                fmt.Printf("%d ", nums[k])
            }
        }
        fmt.Println("")
    }
}
