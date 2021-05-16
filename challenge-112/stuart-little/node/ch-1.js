#!/usr/bin/env node

// run <script> <path>

const path = require('path');

console.log(path.resolve(process.argv[2]))
