#!/usr/bin/env node

// run <script> <number>

const binNr = (parseInt(process.argv[2]) & 255).toString(2).padStart(8,'0');
console.log(parseInt([0,1,2,3].map(x => binNr.substr(2*x,2).split('').reverse().join('')).join(''),2))
