package ch1

func largestInterval(n int) int {
	var jump, prev int
	for i := 1; i <= n; i++ {
		if !hasUniqueDigits(i) {
			continue
		}
		if prev != 0 {
			jump = max(jump, i-prev)
		}
		prev = i
	}
	return jump
}

func hasUniqueDigits(n int) bool {
	var seen uint16
	for ; n > 0; n /= 10 {
		bit := uint16(1) << (n % 10)
		if seen&bit != 0 {
			return false
		}
		seen |= bit
	}
	return true
}
