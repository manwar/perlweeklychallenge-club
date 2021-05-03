#!/usr/bin/env node

// run <script> <path-to-dict-file, one word per line>

const _ = require('lodash');
const fs = require('fs');

function isSorted(arr) {
    return arr.every((el,ix,ar) => {return ix == ar.length-1 || ar[ix] <= ar[ix+1]})
}

const wrds = fs.readFileSync(process.argv[2]).toString().split("\n");

const res = _.maxBy(
    Object.entries(
	_.groupBy(wrds.filter(wrd => {
	    return isSorted(wrd.toLowerCase().split(''))
	}), 'length')
    ), (entry) => parseInt(entry));

console.log(res);
