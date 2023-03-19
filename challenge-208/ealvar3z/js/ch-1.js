#!/usr/bin/env node

const assert = require('assert');

// Implementation
function solve(a, b) {
	const common = a.filter(e => b.includes(e));

	const minimum_sum = common.reduce((acc, e) => {
		const i = a.indexOf(e);
		const j = b.indexOf(e);
		const sum = i + j;

		if (sum < acc.min_sum) {
			return { elements: [e], min_sum: sum };
		} else if (sum == acc.min_sum) {
			return { elements: [...acc.elements, e], min_sum: sum };
		} else {
			return acc;
		}
	}, { elements: [], min_sum: Infinity });

	return minimum_sum.elements;
}

// Tests
const p = ["Perl", "Raku", "Love"];
const q = ["Raku", "Perl", "Hate"];
const r = solve(p, q);
assert.deepStrictEqual(r.sort(), ["Perl", "Raku"]);

const P = ["A", "B", "C"];
const Q = ["D", "E", "F"];
const R = solve(P, Q);
assert.deepStrictEqual(R, []);

console.log('All tests passed');
