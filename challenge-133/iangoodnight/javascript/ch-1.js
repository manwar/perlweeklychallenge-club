#!/usr/bin/env node
// ch-1.js

/**
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
 *
 * Task 1 > Integer Square Root
 * ============================
 *
 * You are given a positive integer `$N`.
 *
 * Write a script to calculate the integer square root of the given number.
 *
 * Please avoid using built-in function.  Find out more about it here
 * (https://en.wikipedia.org/wiki/Integer_square_root).
 *
 * Examples
 * --------
 *
 * Input: $N = 10
 * Output: 3
 *
 * Input: $N = 27
 * Output: 5
 *
 * Input: $N = 85
 * Output: 9
 *
 * Input: $N = 101
 * Output: 10
 *
 **/

'use strict';

/**
 * Node built-in dependencies
 **/

const readline = require('readline');

/**
 * Our PWC solution
 **/

function returnIntSqrRoot(input) {
  // Validate input
  if (!Number.isInteger(+input) || +input < 0) {
    throw new Error(
      'returnIntSqrRoot expects a positive integer as an argument',
    );
  }
  // Crawl through squares starting with 0
  let i = 0;
  while (i * i <= +input) {
    i += 1;
  }
  // return the highest passing number
  i -= 1;
  return i;
}

/**
 * Utilities
 **/

function repl() {
  return new Promise((resolve) => {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });
    rl.setPrompt(
      'Enter a positive integer (or, type "\x1b[33mexit\x1b[0m" to quit)> ',
    );
    rl.prompt();
    rl.on('line', (line) => {
      const trimmed = line.trim();

      if (trimmed === 'exit' || trimmed === 'n') {
        return rl.close();
      }
      if (trimmed === 'y') return rl.prompt();
      if (Number.isInteger(+trimmed)) {
        console.log('Integer square root:', returnIntSqrRoot(+trimmed));
      } else {
        console.log('Arguments must be positive integers only.');
      }
      return process.stdout.write(
        'Try again? (\x1b[33my\x1b[0m/\x1b[33mn\x1b[0m)> ',
      );
    }).on('close', () => {
      console.log('Goodbye.');
      resolve();
    });
  });
}

function printBanner() {
  const message = 'Integer Square Root Calculator';

  const outline = '='.repeat(message.length);

  const fgCyan = '\x1b[36m';

  const reset = '\x1b[0m';

  const banner = `\n${outline}\n${message}\n${outline}\n`;

  console.log(fgCyan + banner + reset);
}

(async function main() {
  try {
    printBanner();
    await repl();
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
