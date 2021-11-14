#!/usr/bin/env node
// ch-2.js

/**
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-131/
 *
 * Task 2 > Find Pairs
 * ===================
 *
 * You are given a string of delimiter pairs and a string to search.
 *
 * Write a script to return two strings the first with any characters matching
 * the "opening character" set, the second with any matching the "closing
 * character" set.
 *
 * Example 1:
 *
 * Input:
 *
 *  Delimiter pairs: ""[]()
 *
 *  Search String: "I like (parens) and the Apple ][+" they said.
 *
 * Output:
 *
 *  "(["
 *
 *  "])"
 *
 * Example 2:
 *
 * Input:
 *
 *  Delimiter pairs: ** //<>
 *
 *  Search String: /* This is a comment (in some languages) * / <could be a tag>
 *
 *  Output:
 *   /** /<
 *   /** />
 **/

'use strict';

/**
 * Node built-in dependencies
 **/

const readline = require('readline');

/**
 * Here, our Find Pairs function (PWC Solution)
 **/

function findPairs(delimiters = '', string = '') {
  const [openSet, closeSet] = [...delimiters].reduce(
    ([open, close], el, idx) => {
      if (idx % 2) return [open, [...close, el]];
      return [[...open, el], close];
    },
    [[], []]
  );
  return [...string].reduce(
    ([open, close], el) => {
      if (openSet.includes(el)) open.push(el);
      if (closeSet.includes(el)) close.push(el);
      return [open, close];
    },
    [[], []]
  );
}

/**
 * Utilities
 **/

function printResults(results = [[]]) {
  results.forEach(result => {
    console.log(result.join(''));
  });
}

/**
 * And our CLI
 **/

(function main() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  function run() {
    console.log('Welcome to delimiter search (type "exit" or Ctrl+c to quit).');
    rl.question('Please provide delimiter string (ie: []{}**): ', (delims) => {
      if (delims.trim() === 'exit') process.exit(0);
      rl.question('Please provide search string: ', (string) => {
        if (string.trim() === 'exit') process.exit(0);
        console.log('Results: ');
        printResults(findPairs(delims.trim(), string));
        run();
      });
    });
  }
  run();
})();

