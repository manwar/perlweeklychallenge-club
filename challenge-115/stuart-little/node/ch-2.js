#!/usr/bin/env node

// run <script> <space-separated digits>

attemptedOut = process.argv.slice(2).sort().reverse().join("").replace(/(.)([13579]*)$/, '$2$1');
console.log( (parseInt(attemptedOut) % 2 == 0) ? (attemptedOut) : ("No even digits..") );
