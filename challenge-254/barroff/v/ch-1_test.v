#!/usr/bin/env -S v -stats test

module main

fn test_27() {
	assert three_power(27) == true
}

fn test_0() {
	assert three_power(0) == true
}

fn test_6() {
	assert three_power(6) == true
}
