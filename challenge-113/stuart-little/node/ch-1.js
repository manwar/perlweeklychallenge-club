#!/usr/bin/env node

// run <script> <digit>

function lastDigSumm(nr, dig, nrSummands) {
    return ((nr - nrSummands * dig) % 10 == 0) && (nrSummands * dig <= nr) && (nrSummands * ((dig -1) * 10 + dig) >= nr)
}

function lastDig(nr,dig) {
    return [...Array(9)].map((_,i) => i+1).filter(x => lastDigSumm(nr,dig,x)).length >= 1
}

function sol(nr,dig) {
    if (dig == 0) {
	return (nr >= 101 || (nr % 10 == 0))
    }        
    return ((nr >= dig * 11) || lastDig(nr,dig))
}

console.log(sol(...process.argv.slice(2).map(x => parseInt(x))) ? 1 : 0)
