#!/usr/bin/env node

// run <script> <bit position>

console.log(parseInt(process.argv[2]) ^ 2**(parseInt(process.argv[3])-1))
