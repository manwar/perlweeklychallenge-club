package main

func validTimes(time string) int {
	res := 1
	if time[0] == '?' {
		if time[1] == '?' {
			res = 24
		} else {
			if time[1] < '4' {
				res = 3
			} else {
				res = 2
			}
		}
	} else if time[1] == '?' {
		if time[0] < 2 {
			res = 10
		} else {
			res = 4
		}
	}

	if time[3] == '?' {
		res *= 6
	} else {
		res *= 1
	}

	if time[4] == '?' {
		res *= 10
	} else {
		res *= 1
	}
	return res
}
