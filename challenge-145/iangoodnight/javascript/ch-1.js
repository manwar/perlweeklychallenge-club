#!/usr/bin/env node
// ch-1.js

/*******************************************************************************
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
 *
 * ## Task 1 > Dot Product
 * =======================
 *
 * You are given 2 arrays of the same size, `@a` and `@b`.
 *
 * Write a script to implement `Dot Product`.
 *
 * **Example:**
 * ```
 * @a = (1, 2, 3);
 * @b = (4, 5, 6);
 *
 * $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32
 * ```
 *
 ******************************************************************************/

'use strict';

/*******************************************************************************
 * Dependencies ****************************************************************
 ******************************************************************************/

const fs = require('fs');

const path = require('path');

/*******************************************************************************
 * PWC Solution ****************************************************************
 ******************************************************************************/

// Input guard
function areSameLengthArrays(arr1 = [], arr2 = []) {
  const { isArray } = Array;

  return isArray(arr1) && isArray(arr2) && arr1.length === arr2.length;
}

// Solution
function dotProduct(arr1 = [], arr2 = []) {
  const badInput = 'dotProduct expects two equal-length arrays as arguments';

  if (!areSameLengthArrays(arr1, arr2)) throw new Error(badInput);

  return arr1.reduce((sum, multiplicand, idx) => {
    const multiplier = arr2[idx];

    return sum + multiplicand * multiplier;
  }, 0);
}

/*******************************************************************************
 * Utilities *******************************************************************
 ******************************************************************************/

// Checking file types
function isFile(filePath) {
  return fs.lstatSync(filePath).isFile();
}

function isDirectory(filePath) {
  return fs.lstatSync(filePath).isDirectory();
}

// String transformation
function numArrayFromString(str = '') {
  return str.split(',').map((numStr) => parseInt(numStr.trim(), 10));
}

// File handlers
function parseTestCase(filePath = '') {
  if (isFile(filePath)) {
    try {
      const data = fs.readFileSync(filePath, 'utf8');

      const lines = data.split('\n');

      const badCase = 'Test cases are improperly formatted';

      if (!lines.length) throw new Error(badCase);

      const testData = lines.filter(
        (line) => line.trim().length !== 0 && line.trim().charAt(0) !== '#',
      );

      const [firstLine, secondLine, testLine] = testData;

      const arr1 = numArrayFromString(firstLine);

      const arr2 = numArrayFromString(secondLine);

      if (!areSameLengthArrays(arr1, arr2)) throw new Error(badCase);

      const test = parseInt(testLine.trim(), 10);

      if (Number.isNaN(test)) throw new Error(badCase);

      return [arr1, arr2, test];
    } catch (error) {
      return console.log('Problems parsing test cases: ', error);
    }
  }
  console.log(filePath, 'is not a file');

  return null;
}

function printArray(arr = []) {
  return Array.isArray(arr) && arr.join(', ');
}

function assertDotProduct([arr1 = [], arr2 = [], test], filePath = '') {
  try {
    const result = dotProduct(arr1, arr2);

    const testPath = filePath !== '' ? `${filePath}: ` : '';

    console.log(testPath);
    console.log(`@a = ${printArray(arr1)}`);
    console.log(`@b = ${printArray(arr2)}`);
    console.log(`Dot Product: ${result}`);

    if (result === test) {
      return console.log('\x1b[32m%s\x1b[0m', 'Passed \u2690\n');
    }

    return console.log('\x1b[31m%s\x1b[0m', 'Failed \u2715\n');
  } catch (error) {
    return console.log('Something went wrong: ', error);
  }
}

/*******************************************************************************
 * Test runner *****************************************************************
 ******************************************************************************/

(function main() {
  const testPath = process.argv[2] || '../test_cases/ch-1';

  try {
    if (isFile(testPath)) {
      const testElements = parseTestCase(testPath);

      return assertDotProduct(testElements, testPath);
    }
    if (isDirectory(testPath)) {
      return fs.readdirSync(testPath).forEach((fileName) => {
        const filePath = path.join(testPath, fileName);

        const testElements = parseTestCase(filePath);

        return testElements && assertDotProduct(testElements, filePath);
      });
    }
    return console.log('No tests found');
  } catch (error) {
    return console.log('Something went wrong: ', error);
  }
})();
