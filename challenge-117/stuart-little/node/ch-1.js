#!/usr/bin/env node

// run <script> <path-to-file>

const fs=require('fs')
const nrs=fs.readFileSync(process.argv[2]).toString().split("\n").map(x => parseInt(x)).filter(x => x)
console.log((nrs.length+2)*(nrs.length+1)/2 - nrs.reduce((x,y) => x+y, 0))
