#!/usr/bin/env node

// run <script> <x1 y1 x2 y2 ..>

function sqDist(coords) {
    return (coords[2]-coords[0])**2 + (coords[3]-coords[1])**2
}

function sqDistHash(coords) {
    let hsh={};
    [0,1,2].forEach( function(i) {
	[0,1,2,3].slice(i+1).forEach( function(j) {
	    let dst = sqDist([2*i,2*i+1,2*j,2*j+1].map(ix => coords[ix]))
	    hsh[dst] = hsh[dst] ? hsh[dst]+1 : 1
	})
    })
    return hsh
}

function isSq(coords) {
    const freqs = Object.values(sqDistHash(coords))
    return freqs.includes(2) && freqs.includes(4)
}

console.log(isSq(process.argv.slice(2,10).map(x => parseFloat(x))) ? 1 : 0)
