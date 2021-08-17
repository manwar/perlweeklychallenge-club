#!/usr/bin/env node

// run <script> <number>

function trps(n) {
    let triples=[]
    for (let i=1; i<=Math.floor((n+1)/2); i++) {
	let sqDif = Math.floor(Math.sqrt(n**2-i**2))
	if ((i<n) && (i**2+sqDif**2==n**2)) {
	    triples.push([i,sqDif,n])
	}
    }
    for (let i=1; i<n; i++) {
	if ((n**2 % i == 0) && ((i%2) === ((Math.floor(n**2/i))%2))) {
	    let s = Math.floor(n**2/i)
	    triples.push([Math.floor((s-i)/2), n, Math.floor((s+i)/2)])	    
	}
    }
    return triples
}

const sol = trps(parseInt(process.argv[2]));
if (sol.length>0) {
    sol.forEach(x => console.log(x));
    process.exit()
}
console.log(-1)
