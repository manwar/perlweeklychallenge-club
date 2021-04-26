#!/usr/bin/env node

// run <script> <path-to-file or nothing>
// defaults to challenge sample if no file is entered

const fs = require('fs');

const data = (process.argv.length<=2) ? (`0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341
`) : fs.readFileSync(process.argv[2], 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
    return data;
});

let rgx = new RegExp(/((?:\+\d{2}|\(\d{2}\)|\d{4})\s+\d{10})/,'g');
for (nr of [...data.matchAll(rgx)].map(x => x[0])) {
    console.log(nr);
};
