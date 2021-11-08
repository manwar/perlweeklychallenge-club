#!/usr/bin/env node

/**
 * Task #1 > Disjoint Sets
 * =======================
 *
 * You are given two sets with unique integers.
 * Write a script to figure out if they are disjoint.
 *
 * The two sets are disjoint if they don't have any common members
 *
 * EXAMPLE
 * Input: const s1 = [1, 2, 5, 3, 4];
 *        const s2 = [4, 6, 7, 8, 9];
 * Output: false as the given sets have common member 4.
 *
 * Input: const s1 = [1, 3, 5, 7, 9];
 *        const s2 = [0, 2, 4, 6, 8];
 * Output: true as the given two sets do no have a common member
 **/

'use strict';

/**
 * Node dependencies
 **/

const fs = require('fs');

const path = require('path');

/**
 * Here, the function to test our sets (PWC solution)
 **/

function isDisjoint(set1 = [], set2 = []) {
  const testSet = [...set1];           // shallow copy of the first set

  let disjoint = true;                 // trust, but verify
  while (disjoint && testSet.length) {
    const test = testSet.pop();
   if (set2.includes(test)) disjoint = false;
  }
  return disjoint;
}

/**
 * Followed by some utilities to test our solution
 **/

const isFile = (filePath) => fs.lstatSync(filePath).isFile();

const isDirectory = (filePath) => fs.lstatSync(filePath).isDirectory();

function parseTestCase(filePath = '') {
  try {
    const data = fs.readFileSync(filePath, 'utf8');

    const lines = data.split('\n');

    if (!lines.length) throw new Error('Test cases improperly formatted');

    const testData = lines.filter((line) => {
      return line.length !== 0 && line.charAt(0) !== '#';
    });

    const [ firstLine, secondLine, result ] = testData;

    const set1 = listToArray(firstLine);

    const set2 = listToArray(secondLine);

    const test = parseInt(result.trim()) === 1 ? true: false;

    return [set1, set2, test];
  } catch (err) {
    console.log('Problems parsing test files: ', err);
  }
}

function listToArray(str) {
  return str.split(',').map(el => el.trim());
}

function assertDisjoint([set1, set2, test], filePath = '') {
  const disjoint = isDisjoint(set1, set2);

  const testPath = filePath !== '' ? `${filePath}: `: '';

  if (disjoint === test) {
    return console.log(`${testPath}\x1b[32m%s\x1b[0m`, 'Passed \u2690');
  }
  return console.log(`${testPath}\x1b[31m%s\x1b[0m`, 'Failed \u2715');
}

/**
 * And, our test runner
 **/

(function main() {
  const testPath = process.argv[2] || '../test_cases/ch1';

  try {
    if (isFile(testPath)) {
      const test = parseTestCase(data);

      return assertDisjoint(test, testPath);
    }
    if (isDirectory(testPath)) {
      fs.readdirSync(testPath).map(fileName => {
        const filePath = path.join(testPath, fileName);

        const test = parseTestCase(filePath);

        assertDisjoint(test, filePath);
      });
      return;
    }
    return 'No tests found';
  } catch (error) {
    console.log('Something went wrong: ', error);
  }
})();
