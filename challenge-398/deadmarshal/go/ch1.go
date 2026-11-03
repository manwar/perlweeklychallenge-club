package ch1

func divisibleAverage(arr []int) int {
	sum, count := 0, 0
	for _, v := range arr {
		if v%2 == 0 && v%3 == 0 {
			sum += v
			count++
		}
	}
	if count == 0 {
		return 0
	}
	return sum / count
}
