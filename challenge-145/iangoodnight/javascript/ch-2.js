#!/usr/bin/env node
// ch-1.js

/*******************************************************************************
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
 *
 * ## Task2 > Palindromic Tree
 * ===========================
 *
 * You are given a string `$s`.
 *
 * Write a script to create a `Palindromic Tree` for the given string
 *
 * I found this [blog] explaining `Palindromic Tree` in detail.
 *
 * **Example 1:**
 *
 * ```
 * Input: $s = 'redivider'
 * Output: r redivider e edivide d divid i ivi v
 * ```
 *
 * **Example 2:**
 *
 * ```
 * Input: $s = 'deific'
 * Output: d e i ifi f c
 * ```
 *
 * **Example 3:**
 *
 * ```
 * Input: $s = 'rotors'
 * Output: r rotor o oto t s
 * ```
 *
 * **Example 4:**
 *
 * ```
 * Input: $s = 'challenge'
 * Output: c h a l ll e n g
 * ```
 *
 * **Example 5:**
 *
 * ```
 * Input: $s = 'champion'
 * Output: c h a m p i o n
 * ```
 *
 * **Example 6**
 *
 * ```
 * Input: $s = 'christmas'
 * Output: c h r i s t m a
 * ```
 *
 * [blog]: https://medium.com/@alessiopiergiacomi/eertree-or-palindromic-tree-82453e75025b
 *
 ******************************************************************************/

'use strict';

const fs = require('fs');

const path = require('path');

/*******************************************************************************
 * PWC Solution ****************************************************************
 ******************************************************************************/

function getPalindromes(str = '') {
  const isPalindrome = (s = '') => s === s.split('').reverse().join('');

  const palindromes = [];

  [...[...str].keys()].forEach((idx) => {
    const substr = str.slice(0, idx + 1);

    if (isPalindrome(substr)) palindromes.push(substr);
  });

  return palindromes;
}

// The blog mentioned in the challenge description describes a pretty
// interesting data structure to tackle this challenge.  My approach here is not
// nearly as nice.
function eertree(str = '') {
  let palindromes = [];

  [...[...str].keys()].forEach((idx) => {
    const substr = str.slice(idx);

    const subPalindromes = getPalindromes(substr);

    palindromes = Array.from(new Set([...palindromes, ...subPalindromes]));
  });

  return palindromes.join(' ');
}

/*******************************************************************************
 * Utilities *******************************************************************
 ******************************************************************************/

function parseTestCase(filePath = '') {
  try {
    const data = fs.readFileSync(filePath, 'utf8');

    const lines = data.split('\n');

    const [input, output] = lines.filter(
      (line) => line.trim().charAt(0) !== '#',
    );

    return [input.trim(), output.trim()];
  } catch (error) {
    console.log(`Problems parsing ${filePath}: ${error}`);
    return [];
  }
}

function printParams(filePath = '', input = '', output = '') {
  console.log(`${filePath}:\nInput: $s = ${input}\nOutput: ${output}`);
  return true;
}

function testSolution(solution = () => {}, input = '', test = '') {
  const result = solution(input);

  if (test === result) {
    return console.log('\x1b[32m%s\x1b[0m', 'Passed \u2690\n');
  }
  return console.log('\x1b[31m%s\x1b[0m', 'Failed \u2715\n');
}

function isFile(filePath) {
  return fs.lstatSync(filePath).isFile();
}

function isDirectory(filePath) {
  return fs.lstatSync(filePath).isDirectory();
}

/*******************************************************************************
 * Main ************************************************************************
 ******************************************************************************/

(function main() {
  const testPath = process.argv[2] || '../test_cases/ch-2';

  try {
    if (isFile(testPath)) {
      const [input, test] = parseTestCase(testPath);

      return (
        input &&
        test &&
        printParams(testPath, input, test) &&
        testSolution(eertree, input, test)
      );
    }
    if (isDirectory(testPath)) {
      return fs.readdirSync(testPath).forEach((fileName) => {
        const filePath = path.join(testPath, fileName);

        const [input, test] = parseTestCase(filePath);

        return (
          input &&
          test &&
          printParams(filePath, input, test) &&
          testSolution(eertree, input, test)
        );
      });
    }
    return 1;
  } catch (error) {
    return console.log('Something went wrong:', error);
  }
})();
