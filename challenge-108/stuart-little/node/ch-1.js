#!/usr/bin/env node

// run <script>
// ref: https://github.com/node-ffi-napi/ref-napi

let ref = require('ref-napi');
let buf = Buffer.alloc(8);
buf.writeInt32LE(5, 0);

buf.type = ref.types.int;
console.log(`The buffer buf holds the value ${buf.deref()} and its memory location is ${parseInt(buf.hexAddress(), 16)}.`);
