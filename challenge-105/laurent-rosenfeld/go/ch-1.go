package main
import (
    "fmt"
    "math"
)
func main() {
    const input = 248832

    for i := 1; i <= 10; i++ {
        fmt.Printf("%2d\t%10.3f\n", i, math.Pow(input, 1.0/float64(i)))
    }
}
