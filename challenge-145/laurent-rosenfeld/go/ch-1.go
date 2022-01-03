package main
import "fmt"

func main() {
    a1 := [3]int{1, 2, 3}
    a2 := [3]int{4, 5, 6}
    var result int = 0
    for i := 0; i < 3; i++ {
        result += a1[i] * a2[i]
    }
    fmt.Printf("Dot product: %d\n", result)
}
