package main

func smallerGreaterElement(arr []int) int {
	mi, mx := int(1e6), -int(1e6)
	for _, n := range arr {
		if n < mi {
			mi = n
		}
		if n > mx {
			mx = n
		}
	}
	res := 0
	for _, n := range arr {
		if mi < n && n < mx {
			res++
		}
	}
	return res
}
