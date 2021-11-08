#!/usr/bin/env node

// run <script> <number>

console.log(`${parseInt((parseInt(process.argv[2]) & 15).toString(2).padStart(4,'0') + (parseInt(process.argv[2]) >> 4 & 15).toString(2).padStart(4,'0'),2)}`)
