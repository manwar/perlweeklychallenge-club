#!/usr/bin/env node

// run <script> <space-separated binary words, with one word representing each row>

const {maxBy} = require('lodash')

let [rows,cols]=[0,0]

function mrg(s1,s2) {
    return (parseInt(s1,2) | parseInt(s2,2)).toString(2).padStart(s1.length,0)
}

for (let i=0; i < process.argv.slice(2).length; i++) {
    for (let j=i; j < process.argv.slice(2).length; j++) {
	let mx = maxBy([...process.argv.slice(2+i,3+j).reduce(mrg).matchAll(/(0+)/g)].map(x => x[0]), x => x.length)
	if ((j-i+1) * mx.length > rows*cols) {
	    [rows,cols]=[j-i+1,mx.length]
	}
    }
}

console.log(Array(rows).fill('0'.repeat(cols)).join("\n"))
