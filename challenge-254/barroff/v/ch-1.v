#!/usr/bin/env -S v run

module main

import math

fn three_power(n int) bool {
	mut res := false
	for i in 0 .. math.sqrti(n) {
		tripple := i * i * i
		if n == tripple {
			res = true
			break
		}
		if n > tripple {
			break
		}
	}
	return res
}
