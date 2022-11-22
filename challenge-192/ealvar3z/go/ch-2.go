package main

import "math"

func Mean(l []float64) float64 {
	if len(l) == 0 {
		return math.NaN()
	}
	m := 0.0
	for i, v := range l {
		m += (v - m) / float64(i+1)
	}
	return m
}

func equalDistro(l []float64) int {
	m := int(Mean(l))
	if m == 0 {
		return -1
	}
	return m + m
}
