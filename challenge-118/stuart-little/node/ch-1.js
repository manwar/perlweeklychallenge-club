#!/usr/bin/env node

// run <script> <number>

const bn = parseInt(process.argv[2]).toString(2)
console.log(0+(bn === bn.split("").reverse().join("")))

