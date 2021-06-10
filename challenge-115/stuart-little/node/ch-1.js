#!/usr/bin/env node

// run <script> <space-separated strings>

function canChain(words,start,end) {
    if (words.length === 0) {return 0}
    if (words.length === 1) {
	return 0+(words[0].slice(0,1) === start && words[0].slice(-1) === end)
    }
    const startIdxs = words.map((el,ix) => ix).filter(ix => words[ix].slice(0,1) === start)
    return 0+( startIdxs.map(ix => canChain(words.map((el,ix) => ix).filter(x => x !== ix).map( ix => words[ix] ), words[ix].slice(-1), end)).some(x => x) )    
}

console.log((process.argv.length < 4) ? (0) : (canChain(process.argv.slice(3), process.argv[2].slice(-1), process.argv[2].slice(0,1))))
