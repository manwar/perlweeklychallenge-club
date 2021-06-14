#!/usr/bin/env node

// run <script> <number>

const digSqSum=process.argv[2].split('').map(x => parseInt(x) ** 2).reduce((x,y) => x+y)
console.log(0+(Math.floor(Math.sqrt(digSqSum)) ** 2 == digSqSum))
