package ch1

func absentSmallestPositive(arr []int) int {
	sum, h := 0, make(map[int]struct{}, len(arr))
	for _, e := range arr {
		h[e] = struct{}{}
		sum += e
	}
	ret := max(1, sum/len(arr)+1)
	for {
		if _, ok := h[ret]; !ok {
			break
		}
		ret++
	}
	return ret
}
