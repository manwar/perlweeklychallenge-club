// Write a script that can convert integers to and from a base35 representation, using the characters 0-9 and A-Y.
package main

import (
	"errors"
	"fmt"
	"log"
	"math/big"
	"os"
	"strconv"
)

func main() {
	guide := `Example:
To convert from base10to35, go run ch-2.go 10to35 1653676305073
pokgopun
To convert from base35to10, go run ch-2.go 35to10 PokGoPun
1653676305073`
	if len(os.Args) < 2 {
		fmt.Println(guide)
	} else {
		switch os.Args[1] {
		case "10to35":
			n, err := strconv.Atoi(os.Args[2])
			if err != nil {
				log.Fatal(err)
			}
			fmt.Println(base10To35(n))
		case "35to10":
			n, err := base35To10(os.Args[2])
			if err != nil {
				log.Fatal(err)
			}
			fmt.Println(n)
		default:
			fmt.Println(guide)
		}
	}
}
func base10To35(n int) string {
	return big.NewInt(int64(n)).Text(35)
}
func base35To10(str string) (int, error) {
	i := new(big.Int)
	j, ok := i.SetString(str, 35)
	if ok {
		return int(j.Int64()), nil
	}
	return 0, errors.New("conversion failed")
}
