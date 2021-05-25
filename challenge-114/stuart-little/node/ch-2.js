#!/usr/bin/env node

// run <script> <number>

const binNr = '0'+parseInt(process.argv[2]).toString(2);
console.log(`Initial number in base two: ${binNr}`);
const nxt = (process.argv[2] % 2) ? (binNr.replace(/01(1*)$/, '10$1')) : (binNr.replace(/01(1*)(0*)$/, '10$2$1'));
console.log(`Next number in base two: ${nxt}`);
console.log(`Next number in base ten: ${parseInt(nxt,2)}`)
