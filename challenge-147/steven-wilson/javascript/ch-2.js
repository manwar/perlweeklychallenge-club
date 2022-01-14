#!/usr/bin/env node
// Week 147 Task 2
// Pentagon Numbers
// Write a sript to find the first pair of Pentagon Numbers
// whose sum and difference are also a Pentagon Number.
// Answer: First pair is 1560090 and 7042750

var pentagonal_numbers = [1]
var pair_found = false
var number = 2

while (!pair_found) {
	let next_pn = pentagonal_number(number)
	for (let i = 0; i < pentagonal_numbers.length; i++) {
		if ((is_pentagonal_number(next_pn - pentagonal_numbers[i])) && 
			(is_pentagonal_number(next_pn + pentagonal_numbers[i]))) {
			console.log('First pair are ' + pentagonal_numbers[i] + ' and ' + next_pn)
			pair_found = true
			break
		}
	}
	pentagonal_numbers.push(next_pn)
	number++
}

function pentagonal_number (number) {
	return ( ( 3 * ( number * number ) ) - number ) / 2
}

function is_pentagonal_number (number) {
	let remainder = ( Math.sqrt( 24 * number + 1 ) + 1 ) % 6;
    if ( remainder > 0 ) {
    	return false
    }
    else {
    	return true
    }
}
