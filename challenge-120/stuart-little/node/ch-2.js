#!/usr/bin/env node

// run <script> <time>

function angl(h,m) {
    const rawDiff = Math.abs((h % 12)*30 + m/2 - m * 6);
    return Math.min(rawDiff,360-rawDiff);
}

console.log(angl(...process.argv[2].split(':').map(x => parseInt(x))))
