#!/usr/bin/env node
// ch-1.js

/**
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-131/
 *
 * Task 1 > Consecutive Arrays
 * ===========================
 *
 * You are given a sorted list of unique positive integers.
 *
 * Write a script to return lists of arrays where the arrays are consecutive
 * integers.
 *
 * Example 1:
 *
 * const input = [1, 2, 3, 6, 7, 8, 9];
 *
 * const output =[[1, 2, 3], [6, 7, 8, 9]];
 *
 * Example 2:
 *
 * const input = [11, 12, 14, 17, 18, 19];
 *
 * const output = [[2], [4], [6], [8]];
 *
 * Example 3:
 *
 * const input = [2, 4, 6, 8];
 *
 * const output = [[2], [4], [6], [8]];
 *
 * Example 4:
 *
 * const input = [1, 2, 3, 4, 5];
 *
 * const output = [[1, 2, 3, 4, 5]];
 **/

'use strict';

/**
 * Node built-in dependencies (required for test runner)
 **/

const fs = require('fs');

const path = require('path');

/**
 * Here, our Consecutive Array Reducer (PWC Solution)
 **/

function reduceToConsecutive(input = []) {
  return input.reduce((reduced, element) => {
    // If no arrays in `reduced`, initialize our first set and return.
    if (reduced.length === 0) return [[element]];
    // Otherwise, pop off the last set for inspection.
    const lastSet = reduced.pop();
    // Take a copy of the last value.
    const [ last ] = lastSet.slice(-1);
    // if the last value is equal to one less than our current value, push it
    // to the last set and push our last set back into our `reduced` array.
    if (last === element - 1) {
      lastSet.push(element);
      reduced.push(lastSet);
    } else {
      // Else, push our unaltered last set, and our new set back to the array.
      reduced.push(lastSet, [element]);
    }
    return reduced;
  }, []);
}

/**
 * Followed by some utilities to test our solution
 **/

function evalInput(input = '') {
  if (input.indexOf('[') === -1) {
    // No inner sets, input string, split and return
    return input
      .replace(/\(|\)/g, '')
      .split(/\s*,\s*/)
      .map((element) => parseInt(element)
    );
  }
  // Else, answer string, parse and return
  return [...input.matchAll(/\[([^\]]*)\]/g)].map(match =>
    match[1].split(/\s*,\s*/).map(el => parseInt(el))
  );
}

function parseTestCase(filePath = '') {
  try {
    const data = fs.readFileSync(filePath, 'utf8');

    const [ inputsArray, answersArray ] = data.split('\n').reduce(
      ([inputs, tests], line) => {
        const trimmed = line.trim();
        // Discard comments and blank lines
        if (trimmed.charAt(0) === '#' || trimmed.length === 0) {
          return [inputs, tests];
        }
        // Parse line
        const parsed = evalInput(trimmed);
        // if inputs greater than tests, assume line is a test
        if (inputs.length > tests.length) return [inputs, [...tests, parsed]];
        // else, push parsed to inputs
        return [[...inputs, parsed], tests];
      },
      [[], []]
    );
    // Grab lengths for comparison conveniences
    const { length: inputLength } = inputsArray;

    const { length: answerLength } = answersArray;
    // Sanity check
    if (
      inputLength === 0 ||
      answerLength === 0 ||
      inputLength !== answerLength
    ) {
      // Something went wrong parsing the test cases
      throw new Error (
        `Found ${inputLength} inputs and ${answerLength} answers.`
      );
    }
    return [inputsArray, answersArray];
  } catch (error) {
    console.log(`Problems parsing test case(s) at: ${filePath}`);
    console.log(error);
  }
}

function assertMatch(set1 = [], set2 = []) {
  return set1.reduce((match, element, idx) => {
    // Already failed, return
    if (!match) return false;
    // just for conveniance
    const array = Array.isArray(element);

    const compare = set2[idx];
    // Fails
    if (!array && element !== compare) return false;
    // Recurse
    if (array) return assertMatch(element, set2[idx]);
    // Passes
    return match;
  }, true);
}

function printResults(testPath = '', inputs = [], expected = []) {
  console.log(testPath);
  console.log('='.repeat(testPath.length), '\n');
  // Iterates through and print relevant test data.
  inputs.forEach((input, idx) => {
    console.log(`Input: ${JSON.stringify(input)}`);
    console.log(`Expected: ${JSON.stringify(expected[idx])}`);
    const result = reduceToConsecutive(input);
    // Check for match
    console.log(`Result: ${JSON.stringify(result)}`);
    if (assertMatch(expected[idx], result)) {
      console.log('\x1b[32m%s\x1b[0m', 'Passed \u2690');
    } else {
      console.log('\x1b[31m%s\x1b[0m', 'Failed \u2715');
    }
    console.log('\n');
  });
}

const isFile = (filePath) => fs.lstatSync(filePath).isFile();

const isDirectory = (filePath) => fs.lstatSync(filePath).isDirectory();

/**
 * And our test runner
 **/

(function main() {
  const testPath = process.argv[2] || '../test_cases/ch-1';
  // Handle single file inputs
  try {
    if (isFile(testPath)) {
      const [ inputs, tests ] = parseTestCase(testPath);

      return printResults(testPath, inputs, tests);
      // Else, handle directory inputs
    } else if (isDirectory(testPath)) {
      fs.readdirSync(testPath).forEach(fileName => {
        const filePath = path.join(testPath, fileName);

        const [ inputs, tests ] = parseTestCase(filePath);

        printResults(filePath, inputs, tests);
        // Else, no tests found
      });
      return;
    } else {
      console.log('No tests found');
    }
  } catch (error) {
    console.log('Something went wrong: ', error);
  }
})();

