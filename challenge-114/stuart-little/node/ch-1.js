#!/usr/bin/env node

// run <script> <number>

const nrDig = process.argv[2].length;

if (process.argv[2] === '9'.repeat(nrDig)) {
    console.log(parseInt(process.argv[2])+2);
    process.exit();
}

function doubleUp(nrDig, initHalf) {
    return initHalf + ((nrDig % 2) ? (initHalf.substring(0,initHalf.length-1).split('').reverse().join('')) : (initHalf.split('').reverse().join('')))
}
    
const initHalf = process.argv[2].substring(0,Math.floor((nrDig+1)/2));

console.log(
    (parseInt(doubleUp(nrDig,initHalf)) > parseInt(process.argv[2])) ?
	(doubleUp(nrDig,initHalf)) :
	(doubleUp(nrDig,(parseInt(initHalf)+1).toString()))
)
