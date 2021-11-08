#!/usr/bin/env node

// run <script> <number>

function no1(nr){
    if (nr.length === 0) { return 0 }
    if (nr[0] === '1') { return 9**(nr.length-1) }
    return (parseInt(nr[0])-1) * 9**(nr.length-1) + no1(nr.slice(1))
}

console.log((process.argv[2].indexOf('1') === -1) ? (no1(process.argv[2])) : (no1(process.argv[2])-1))
