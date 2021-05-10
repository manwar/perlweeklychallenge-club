#!/usr/bin/env node

// run <script> <number>

let memo = [
    [[1,],],
    [[1,1],[2,]],
];

function memoSteps(n) {
    if (typeof(memo[n]) === 'undefined') {
	memo[n] = [...(memoSteps(n-1).map(x => [1,...x])) , ...(memoSteps(n-2).map(x => [2,...x]))];
    }
    return memo[n]
}

const res = memoSteps(parseInt(process.argv[2])-1);
console.log(`${res.length}
${"-".repeat(12)}`);
res.forEach(x => console.log(x));
