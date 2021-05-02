#!/usr/bin/env node

// run <script> <path-to-file or nothing>
// defaults to challenge sample if no file is entered

const fs = require('fs');
const _ = require('lodash');

const data = (process.argv.length<=2) ? (`name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
`) : fs.readFileSync(process.argv[2], 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
    return data;
});

console.log(
    _.zip(...data.trim().split("\n").map(x => x.split(","))).map(x => x.join(","))
);
