#!/usr/bin/env node

// run <script> <left1 right1 left2 right2 ...>

console.log(
    [...Array(Math.floor(process.argv.slice(2).length/2)).keys()]
	.map(ix => [parseInt(process.argv[2+2*ix]),parseInt(process.argv[3+2*ix])])
	.flatMap((val,ix,ar) => ar.slice(0,ix).map((x) => [x,val]))
	.filter(ar => (ar[1][1] - ar[0][0])*(ar[1][0] - ar[0][1]) <= 0)
	.map(ar => ar[1])
	.filter((val,ix,ar) => ar.indexOf(val)===ix)
)
