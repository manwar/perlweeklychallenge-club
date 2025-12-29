package main

import (
	"fmt"
	"regexp"
)

func validateCoupon(codes, names, status []string) []bool {
	res := []bool{}
	valids := map[string]int{
		"electronics": 1,
		"grocery":     1,
		"pharmacy":    1,
		"restaurant":  1,
	}
	for i, _ := range codes {
		m, _ := regexp.MatchString("^[_0-9a-zA-Z]+$", codes[i])
		_, exists := valids[names[i]]
		if m && exists && status[i] == "true" {
			res = append(res, true)
		} else {
			res = append(res, false)
		}
	}
	return res
}

func main() {
	fmt.Println(validateCoupon([]string{"A123", "B_456", "C789", "D@1", "E123"},
		[]string{"electronics", "restaurant", "electronics", "pharmacy", "grocery"},
		[]string{"true", "false", "true", "true", "true"}))
	fmt.Println(validateCoupon([]string{"Z_9", "AB_12", "G01", "X99", "test"},
		[]string{"pharmacy", "electronics", "grocery",
			"electronics", "unknown"},
		[]string{"true", "true", "false", "true", "true"}))
	fmt.Println(validateCoupon([]string{"_123", "123", "", "Coupon_A", "Alpha"},
		[]string{"restaurant", "electronics", "electronics",
			"pharmacy", "grocery"},
		[]string{"true", "true", "false", "true", "true"}))
	fmt.Println(validateCoupon([]string{"ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"},
		[]string{"electronics", "electronics", "grocery", "grocery"},
		[]string{"true", "true", "true", "true"}))
	fmt.Println(validateCoupon([]string{"CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"},
		[]string{"restaurant", "electronics", "grocery",
			"pharmacy", "electronics"},
		[]string{"true", "true", "true", "true", "false"}))
}
