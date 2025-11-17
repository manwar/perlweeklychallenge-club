package main

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
)

func toMin(s string) (int, error) {
	parts := strings.Split(s, ":")
	h, err1 := strconv.Atoi(parts[0])
	m, err2 := strconv.Atoi(parts[1])
	if je := errors.Join(err1, err2); je != nil {
		return -1, je
	}
	return h*60 + m, nil
}

func convertTime(source string, target string) int {
	a, err1 := toMin(source)
	b, err2 := toMin(target)
	if errors.Join(err1, err2) != nil {
		panic("Wrong format!")
	}
	res, d := 0, (b-a+1440)%1440
	for _, i := range []int{60, 15, 5, 1} {
		res += d / i
		d %= i
	}
	return res
}

func main() {
	fmt.Println(convertTime("02:30", "02:45"))
	fmt.Println(convertTime("11:55", "12:15"))
	fmt.Println(convertTime("09:00", "13:00"))
	fmt.Println(convertTime("23:45", "00:30"))
	fmt.Println(convertTime("14:20", "15:25"))
}
