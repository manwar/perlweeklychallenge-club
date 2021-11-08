#!/usr/bin/env node

// run <script> <number $n> to return the first $n ugly numbers

let memo = new Set([1,2,3,5])

function smth5p(n) {
    if (memo.has(n)) {return true}
    for (let prm of [2,3,5]) {
	if (n%prm===0 && memo.has(n/prm)) {
	    memo.add(n)
	    return true
	}
    }
    return false
}

let count=0
let nr=0
while (count < parseInt(process.argv[2])) {
    nr++
    if (smth5p(nr)) {
	count++
	console.log(nr)
    }    
}
