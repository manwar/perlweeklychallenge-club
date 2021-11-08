package main
import "fmt"

func main() {
    lines := [5]string{"   ^^^^^", "  ^     ^",
        " ^       ^", "^         ^",  "     ^"}
    indexes := [18]int{0, 1, 2, 3, 3, 3, 3, 3, 3, 2, 1, 0, 4, 4, 4, 0, 4, 4}

    for i := 0; i < 18; i++ {
        fmt.Printf("%s\n", lines[indexes[i]])
    }
}
