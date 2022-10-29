#!/usr/bin/env node

'use strict';

function total_zero(x, y) {
	let count = 0;

	while ( x != 0 && y != 0 ) {
		if ( x > y ) {
			x -= y;
			count++;
		}
		if ( y >= x ) {
			y -= x;
			count++;
		}
	}

	return count;
}

[ [ 5, 4 ], [ 4, 6 ], [ 2, 5 ], [ 3, 1 ], [ 7, 4 ] ].forEach(item => console.log(`${item}: `, total_zero(...item)));
