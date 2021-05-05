#!/usr/bin/env node

// run <script>

const _ = require('lodash');

function binFindZero1(needle,mat) {
    return (_.sortedIndexOf(_.flatten(mat),needle) >= 0) ? (1) : (0);
}

const inArr = [
    [  1,  2,  3,  5,  7 ],
    [  9, 11, 15, 19, 20 ],
    [ 23, 24, 25, 29, 31 ],
    [ 32, 33, 39, 40, 42 ],
    [ 45, 47, 48, 49, 50 ],
];

const toSearch = [1,35,39,100];

console.log("Array:");
inArr.forEach(row => console.log(row));

toSearch.forEach(
    needle => {
	console.log(`\nFound ${needle}?`);
	console.log(binFindZero1(needle,inArr));
    });
