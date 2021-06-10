#!/usr/bin/env node

// run <script> <path-to-module>
// defaults to the 'os' module

const mdl = (process.argv.length <= 2) ? ('os') : (process.argv[2]);
const obj = require(mdl);

console.log(
    Object.getOwnPropertyNames(obj)
	.filter((key) => (typeof obj[key]) === 'function')
	   );
