#!/usr/bin/env node

'use strict';

function find_div_pairs(k, list) {
	let count = 0;

	for (let i = 0; i < list.length - 1; i++)
		for (let j = i + 1; j < list.length; j++)
			if ( (list[i] + list[j]) % k === 0 )
				count += 1;

	return count;
}

const lists = [
    [ 2, [ 4, 5, 1, 6 ] ],
    [ 2, [ 1, 2, 3, 4 ] ],
    [ 3, [ 1, 3, 4, 5 ] ],
    [ 4, [ 5, 1, 2, 3 ] ],
    [ 4, [ 7, 2, 4, 5 ] ],
];

console.log( lists.map(item => find_div_pairs(...item)).filter(item => item != 0) );
