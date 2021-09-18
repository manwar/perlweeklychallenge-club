#!/usr/bin/env node

/**
 * ch-1.js
 *
 * Task 1 > Odd Number
 * ===================
 *
 * You are given an array of positive integers, such that all the numbers appear
 * an even number of times except one number.
 *
 * Write a script to find that integer.
 *
 * Example 1
 * =========
 *
 * const input = [2, 5, 4, 4, 5, 5, 2];
 *
 * const output = 5; // as it appears 3 times in the array whereas all other
 *                   // numbers 2 and 4 appear exactly twice
 *
 * Example 2
 * =========
 *
 * const input = [1, 2, 3, 4, 3, 2, 1, 4, 4];
 *
 * const output = 4;
 **/

'use strict';

/**
 * Node built-in dependencies
 **/

const fs = require('fs');

const path = require('path');

/**
 * Here, our input reducer (PWC solution)
 **/

function reduceToOddCount(input = []) {
  // First, reduce our input to a map of values and counts
  const mapped = input.reduce((counts, value) => {
    if (counts && Object.prototype.hasOwnProperty.call(counts, '' + value)) {
      counts['' + value] += 1;
    } else {
      counts['' + value] = 1;
    }
    return counts;
  },{});
  // Technically, our challenge states that there will only ever be one odd
  // input count, but, just for fun, we'll design it to return all odd counts
  // in the case that we get improperly validated input.
  let odd = [];
  for (const [key, value] of Object.entries(mapped)) {
    // Iterate through, pushing values with odd counts to our `odd` array
    if (value % 2 !== 0) {
      odd.push(key);
    }
  }
  // Handle our possible results:
  switch (odd.length) {
    case 0:
      // Tricky input, no correct answer.
      return 'No odd counts found';
    case 1:
      // Input as expected, return correct answer
      return odd[0];
    default:
      // Incorrectly validated input, be the bigger person and just return all
      // correct answers in our odd array.
      return odd;
  }
}

/**
 * Followed by some utilities to test our solution
 **/

function parseTestCase(filePath = '') {
  try {
    const data = fs.readFileSync(filePath, 'utf8');

    const [ inputsArray, answersArray ] = data.split('\n')
      .reduce(([inputs, tests], line) => {
        if (line.charAt(0) === '#' || line.length === 0) {
          return [inputs, tests];
        }
        if (inputs.length > tests.length) {
          tests.push(line.trim());
          return [inputs, tests];
        }
        inputs.push(line.split(',').map(el => el.trim()));
        return [inputs, tests];
      }, [[], []]
    );

    const { length: inputsLength } = inputsArray;

    const { length: answersLength } = answersArray;

    if (
      inputsLength === 0 ||
      answersLength === 0 ||
      inputsLength !== answersLength
    ) {
      console.log('Problems parsing test cases at: ', filePath);
      process.exit(1);
    }

    return [inputsArray, answersArray];
  } catch (error) {
    console.log('Problems parsing test cases at: ', filePath);
    console.log(error);
  }
}

function assertMatch(input = [], expected) {
  console.log('\nInput: ', input.join(', '));
  const result = reduceToOddCount(input);

  const type = typeof result;

  // Handles singles results
  if (type === 'number' || type === 'string') {

    console.log('Expected: ', expected);
    console.log('Result: ', result);

    if (result === expected) {
      return console.log('\x1b[32m%s\x1b[0m', 'Passed \u2690');
    }
    return console.log('\x1b[31m%s\x1b[0m', 'Failed \u2715');
  }

  if (type === 'object' && Array.isArray(result)) {
    const answerArray = expected.split(',')
      .map(el => el.trim()).sort();

    result.sort();

    console.log('Expected: ', answerArray.join(', '));
    console.log('Result: ', result.join(', '));

    const passed = answerArray.reduce((passes, answer, idx) => {
      if (answer !== result[idx]) passes = false;
      return passes;
    }, true)

    if (passed) return console.log('\x1b[32m%s\x1b[0m', 'Passed \u2690');
    return console.log('\x1b[31m%s\x1b[0m', 'Failed \u2715');
  }
  return 'Problems asserting match.'
}

const isFile = (filePath) => fs.lstatSync(filePath).isFile();

const isDirectory = (filePath) => fs.lstatSync(filePath).isDirectory();

/**
 * And our test runner
 **/

(function main() {
  const testPath = process.argv[2] || '../test_cases/ch-1';

  try {
    if (isFile(testPath)) {
      const [inputs, tests] = parseTestCase(testPath);

      console.log(testPath);
      console.log('='.repeat(testPath.length));

      if (tests.length > 1) {
        tests.forEach((test, i) => {
          assertMatch(inputs[i], test);
        });
        return;
      }
      return assertMatch(inputs[0], tests[0]);
    }

    if (isDirectory(testPath)) {
      fs.readdirSync(testPath).map(fileName => {
        const filePath = path.join(testPath, fileName);

        const [inputs, tests] = parseTestCase(filePath);

        console.log(testPath);
        console.log('='.repeat(filePath.length));
        if (tests.length > 1) {
          tests.forEach((test, i) => {
            assertMatch(inputs[i], test);
          });
        } else {
          assertMatch(inputs[0], tests[0]);
        }
        console.log('\n');
      });
      return;
    }
    return 'No tests found';
  } catch (error) {
    console.log('Something went wrong: ', error);
  }
})();
