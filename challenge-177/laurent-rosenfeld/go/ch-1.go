import (
    "fmt"
    "strconv"
)

var damm = [10][10] int {
    {0, 3, 1, 7, 5, 9, 8, 6, 4, 2},
    {7, 0, 9, 2, 1, 5, 4, 8, 6, 3},
    {4, 2, 0, 6, 8, 7, 1, 3, 5, 9},
    {1, 7, 5, 0, 9, 8, 3, 4, 2, 6},
    {6, 1, 2, 3, 0, 4, 5, 9, 7, 8},
    {3, 6, 7, 4, 2, 0, 9, 5, 8, 1},
    {5, 8, 6, 9, 7, 2, 0, 1, 3, 4},
    {8, 9, 4, 5, 3, 6, 2, 0, 1, 7},
    {9, 4, 3, 8, 6, 1, 7, 2, 0, 5},
    {2, 5, 8, 1, 4, 3, 6, 7, 9, 0},
}

func is_valid(num int) bool {
    var n_str = strconv.Itoa(num)
    var temp = 0
    for _, ch := range n_str {
        temp = damm[temp][ch-'0']
    }
    return temp == 0
}

func main() {
    fmt.Println("Valid numbers between 5700 and 5800 are:")
    for i := 5700; i <= 5800; i++ {
        if is_valid(i) {
            fmt.Printf("%d ", i)
        }
    }
    fmt.Println("")
}
