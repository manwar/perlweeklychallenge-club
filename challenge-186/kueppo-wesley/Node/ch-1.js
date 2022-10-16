#!/usr/bin/env node

'use strict';

function zip( ...lists ) {
	let results = [];
	[ ...Array( lists.map( item => item.length ).sort()[0] ).keys() ].forEach( index => results.push( ...lists.map(item => item[index]) ) );
	return results;
}

let a = [ 1, 2, 3 ], b = [ 'a', 'b', 'c' ], c = ['e', 'f', ...a ];

console.log( zip(a, b) );
console.log( zip(b, a) );
console.log( zip(c, a) );
console.log( zip(b, c, a) );
