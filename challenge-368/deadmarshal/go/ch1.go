package main

func makeItBigger(number string, digit byte) string {
	idx := -1
	for i := 0; i < len(number); i++ {
		if number[i] != digit {
			continue
		}
		if i+1 < len(number) && number[i] < number[i+1] {
			idx = i
			break
		}
		idx = i
	}
	return number[:idx] + number[idx+1:]
}
