// Go big int syntax really sucks
package main

import (
    "fmt"
    "math/big"
)

func main() {
    s := big.NewInt(2)
    fmt.Println(0, ": ", s)
    one := big.NewInt(1)
    for i := 1; i <= 9; i++ {
        s.Add(new(big.Int).Mul(s, s), new(big.Int).Sub(one, s))
        fmt.Println(i, ": ", s)
    }
}
