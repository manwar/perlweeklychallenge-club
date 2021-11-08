#!/usr/bin/env node

/**
 * Task #2 > Conflict Intervals
 * ============================
 *
 * You are given a list of intervals.
 * Write a script to find out if the current interval conflicts with any of the
 * previous intervals.
 *
 * EXAMPLE
 * Input: const intervals = [[1, 4], [3, 5], [6, 8], [12, 13], [3, 20]];
 * Output: [[3, 5], [3, 20]]
 *
 *   - The 1st interval [1, 4] does not have any previous intervals to compare
 *     with, so skip it.
 *   - The 2nd interval [3, 5] does conflict with previous interval [1, 4].
 *   - The 3rd interval [6, 8] does not conflict with any of the previous
 *     intervals [1, 4] and [3, 5], so skip it.
 *   - The 4th interval [12, 13] again does not conflict with any previous
 *     intervals [1, 4], [3, 5], or [6, 8] so skip it.
 *   - The 5th interval [3, 20] conflicts with the first interval [1, 4].
 *
 * Input: const intervals = [[3, 4], [5, 7], [6, 9], [10, 12], [13, 15]];
 * Output: [[6, 9]];
 **/

'use strict';

/**
 * Built-in Node dependencies
 **/

const fs = require('fs');

const path = require('path');

/**
 * Here, the function to test our intervals (PWC solution)
 **/

function findConflictIntervals(intervals = [[]]) {
  if (!Array.isArray(intervals)) return 'Input must be an 2-dimensional array';
  const [conflicts, ] = intervals.reduce(([conflicts, passed], [ a1, a2 ]) => {
    const start = a1 < a2 ? a1: a2;

    const end = start === a1 ? a2: a1;

    if (passed.length === 0) {
      passed.push([start, end]);
      return [conflicts, passed];
    }
    const conflict = passed.reduce((isConflict, [ b1, b2 ]) => {
      if (
        (start >= b1 && start <= b2) ||
        (end >= b1 && end <= b2) ||
        (start <= b1 && end >= b2)
      ) {
        return true;
      };
      return isConflict;
    }, false);
    if (conflict) {
      conflicts.push([start, end]);
    } else {
      passed.push([start, end]);
    }
    return [conflicts, passed]
  }, [[], []]);
  return conflicts;
}

/**
 * Followed by some utilities to test our solution
 **/


const isFile = (filePath) => fs.lstatSync(filePath).isFile();

const isDirectory = (filePath) => fs.lstatSync(filePath).isDirectory();

function parseTestCase(filePath = '') {
  try {
    const data = fs.readFileSync(filePath, 'utf8');

    const { input, output } = JSON.parse(data);

    return { input, output };
  } catch (err) {
    console.log(
      'Problems parsing text files. Is the JSON properly formatted?',
      err
    );
  }
}

function sortIntervals(intervalsArr = [[]]) {
  const intervalsSorted = intervalsArr.map(([x, y]) => {
    return x > y ? [x, y]: [y, x];
  });
  intervalsSorted.sort(([a1, a2], [b1, b2]) => {
    if (a1 === b1) return b1 < b2 ? -1: b1 === b2 ? 0: 1;
    if (a1 < b1) return -1;
    return 1;
  });
  return intervalsSorted;
}

function compareIntervalSets(set1 = [[]], set2 = [[]]) {
  if (!Array.isArray(set1) || !Array.isArray(set2)) return false;
  if (set1.length !== set2.length) return false;
  const set1Sorted = sortIntervals(set1);

  const set2Sorted = sortIntervals(set2);

  return set1Sorted.reduce((equal, [a1, a2], idx) => {
    const [ b1, b2 ] = set2Sorted[idx];

    return equal && a1 === b1 && a2 === b2;
  }, true);
}

function assertConflictIntervals(input = [[]], output = [[]], filePath = '') {
  const conflicts = findConflictIntervals(input);

  const passed = compareIntervalSets(conflicts, output);

  const testPath = filePath === '' ? '' : `${filePath}: `;

  if (passed) {
    return console.log(`${testPath}\x1b[32m%s\x1b[0m`, 'Passed \u2690');
  }
  return console.log(`${testPath}\x1b[31m%s\x1b[0m`, 'Failed \u2715');
}

/**
 * And, our test runner
 **/

(function main() {
  const testPath = process.argv[2] || '../test_cases/ch2';

  try {
    if (isFile(testPath)) {
      const { input, output } = parseTestCase(testPath);

      return assertConflictIntervals(input, output, testPath);
    }
    if (isDirectory(testPath)) {
      fs.readdirSync(testPath).map(fileName => {
        const filePath = path.join(testPath, fileName);

        const { input, output } = parseTestCase(filePath);

        assertConflictIntervals(input, output, filePath);
      });
      return;
    }
    return 'No tests found';
  } catch (error) {
    console.log('Something went wrong: ', error);
  }
})();
