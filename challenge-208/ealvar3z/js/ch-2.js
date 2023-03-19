#!/usr/bin/env node

// Implementation
function solve(misfits) {
	const n = misfits.length;
	
	// elements
	const elements = misfits.reduce((acc, val) => acc + val, 0);
	const sum_of_elements = (n * (n + 1)) / 2;
	const element_diff = sum_of_elements - elements;
	
	// squares
	const squares = misfits.reduce((acc, val) => acc + val * val, 0);
	const sum_of_squares = (n * (n + 1) * (2 * n + 1)) / 6;
	const square_diff = sum_of_squares - squares;
	

	if (element_diff === 0 && square_diff === 0) {
		return -1;
	} else {
		const missing = (element_diff * element_diff + square_diff) / (2 * element_diff);
		const duplicate = missing - element_diff;
		return { duplicate, missing };
	}

}

// Tests
const assert = require('assert');

const a = [1, 2, 3, 4];
const test_a = solve(a);
assert.deepStrictEqual(test_a, -1);

const b = [1, 2, 3, 3];
const test_b = solve(b);
assert.deepStrictEqual(test_b, { duplicate: 3, missing: 4 });

const c = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
const test_c = solve(c);
assert.deepStrictEqual(test_c, -1);

const d = [1, 2, 2, 4];
const test_d = solve(d);
assert.deepStrictEqual(test_d, { duplicate: 2, missing: 3});


console.log('All tests passed');
