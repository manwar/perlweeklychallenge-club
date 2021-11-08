#!/usr/bin/env node

// run <script> <number>

let memo=[[''],['R','LH']]

function crt(lst1, lst2) {
    return lst1.flatMap(x => lst2.map(y => [x,y]))
}

function mkPaths(size) {
    if (size >= memo.length) {
	res=mkPaths(size-1).map(x => 'R' + x)
	res=[...Array(size).keys()]
	    .reduce(
		(lst,ix) => lst.concat(crt(mkPaths(ix), mkPaths(size-1-ix)).map(([x,y]) => 'L'+x+'H'+y)),
		res)
	memo.push(res)
    }
    return memo[size]
}

mkPaths(parseInt(process.argv[2])).forEach(x => console.log(x))
