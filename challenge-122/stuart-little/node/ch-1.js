#!/usr/bin/env node

// run <script> <space-separated numbers>

console.log(
    process.argv.slice(2).map(x => parseFloat(x)).reduce(
	(acc,val,ix) => acc.concat((acc[acc.length-1]*ix+val)/(ix+1)),[0,]).slice(1)
)
