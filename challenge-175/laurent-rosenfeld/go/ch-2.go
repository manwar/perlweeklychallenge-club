import "fmt"

var cache [10000]int

func gcd(i int, j int) int {
    for j != 0 {
        temp := i % j
        i = j
        j = temp
    }
    return i
}

func is_perfect_totient(n int) bool {
    tot := 0
    for i := 1; i < n; i++ {
        if gcd(n, i) == 1 {
            tot++
        }
    }
    sum := tot + cache[tot]
    cache[n] = sum
    return n == sum
}

func main() {
    i := 0
    count := 0
    for count <= 20 {
        if is_perfect_totient(i) {
            fmt.Printf("%d ", i)
            count++
        }
        i++
    }
    fmt.Println("")
}
