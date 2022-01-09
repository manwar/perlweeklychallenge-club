#!/usr/bin/env node
// ch-2.js

/*******************************************************************************
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
 *
 * ## Task 2 > Curious Fraction Tree
 * =================================
 *
 * Consider the following `Curious Fraction Tree`:
 *
 * ```
 *                __________1/1__________
 *               /                       \
 *         ___1/2___                   ___2/1___
 *        /         \                 /         \
 *     1/3           3/2           2/3           3/1
 *    /   \         /   \         /   \         /   \
 * 1/4     4/3   3/5     5/2   2/5     5/3   3/4     4/1
 * ```
 *
 * You are given a fraction, member of the tree created similar to the above
 * sample.
 *
 * Write a script to find out the parent and grandparent of the given member.
 *
 * **Example 1:**
 *
 * ```
 * Input: $member = '3/5';
 * Output: parent = '3/2' and grandparent = '1/2'
 * ```
 *
 * **Example 2:**
 *
 * ```
 * Input: $member = '4/3';
 * Output: parent = '1/3' and grandparent = '1/2'
 * ```
 *
 ******************************************************************************/

'use strict';

/*******************************************************************************
 * Dependencies ****************************************************************
 ******************************************************************************/

const readline = require('readline');

/*******************************************************************************
 * PWC Solution ****************************************************************
 ******************************************************************************/

// Input guard
function isFractionString(string) {
  const re = /^\d+\/\d+$/;

  return typeof string === 'string' && re.test(string.trim());
}

// Find immediate parent
function getCuriousParent(member = '1/1') {
  if (!isFractionString(member)) {
    const badArg = '`getCuriousParent` expects a string (i.e.: "3/4")';

    throw new Error(badArg);
  }

  const [num, den] = member.split('/').map((elem) => parseInt(elem, 10));

  const value = num / den;

  if (value > 1) return `${num - den}/${den}`;
  if (value < 1) return `${num}/${den - num}`;
  return null;
}

// Returns whole chain from member to root
function getCuriousTree(member = '1/1') {
  if (!isFractionString(member)) {
    throw new Error('`getCuriousTree` expects a string (i.e.: "3/2")');
  }

  const parents = [];

  let child = member;

  while (child !== null) {
    parents.push(child);
    child = getCuriousParent(child);
  }

  return parents;
}

// Not really necessarily to abstract this step, but it makes it easier to do
// other things with the whole chain, like figure out if it is rooted at 1/1 or
// not
function getCuriousGenerations(tree = [], generations = 2) {
  return tree.slice(1, generations + 1);
}

/*******************************************************************************
 * Utilities *******************************************************************
 ******************************************************************************/

const colors = {
  green: '\x1b[32m',
  red: '\x1b[31m',
  reset: '\x1b[0m',
  yellow: '\x1b[33m',
};

function formatOutput(tree = [], termColors = {}) {
  const { yellow: y = '', green: g = '', reset: rst = '' } = termColors;

  return tree
    .map((member, idx, array) => {
      const { length } = array;

      const conjunction = idx === length - 1 && length !== 1 ? 'and ' : '';

      const last = idx === length - 1;

      let ordinal = idx === 0 ? 'parent' : 'grandparent';

      if (idx > 1) ordinal = 'great-'.repeat(idx - 1) + ordinal;

      let separator = last ? '' : ', ';

      if (length === 2) separator = ' ';

      return `${conjunction}${y + ordinal + rst} = ${
        g + member + rst
      }${separator}`;
    })
    .join('');
}

function assertRoot(tree = [], termColors = {}) {
  const last = [...tree].pop();

  const {
    green: g = '',
    red: r = '',
    reset: rst = '',
    yellow: y = '',
  } = termColors;

  if (last !== '1/1') {
    return `${y}Curious fraction tree rooted at ${
      r + last + y
    } and not at ${`${g}1/1${rst}`}`;
  }
  return null;
}

function repl(termColors = {}) {
  const { green: g = '', yellow: y = '', reset: rst = '' } = termColors;

  return new Promise((resolve) => {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });

    /* eslint-disable prefer-template */
    const mainPrompt =
      'Enter a fraction (i.e.: "' +
      g +
      '3/5' +
      rst +
      '") or type "' +
      y +
      'exit' +
      rst +
      '" to quit /> ';

    const morePrompt =
      'Enter "' +
      y +
      'more' +
      rst +
      '" to see more details, or enter a fraction (i.e.: "' +
      g +
      '3/5' +
      rst +
      '") to continue /> ';
    /* eslint-enable prefer-template */

    let currentTree;
    let generations;
    let assertedRoot;

    rl.setPrompt(mainPrompt);

    rl.prompt();

    rl.on('line', (line) => {
      const input = line.trim().toLowerCase();

      if (input === 'exit' || input === 'quit' || input === 'q') {
        return rl.close();
      }

      if (isFractionString(input)) {
        currentTree = getCuriousTree(input);
        generations = getCuriousGenerations(currentTree, 2);
        assertedRoot = assertRoot(currentTree, termColors);
        console.log(formatOutput(generations, termColors));
        rl.setPrompt(morePrompt);
        return rl.prompt();
      }

      if (input === 'more') {
        console.log(formatOutput(currentTree.slice(1), termColors));
        if (assertedRoot) console.log(assertedRoot);
        currentTree = null;
        generations = null;
        assertedRoot = null;
        rl.setPrompt(mainPrompt);
        return rl.prompt();
      }
      console.log(`Sorry, I don't understand ${input}.`);
      return rl.prompt();
    }).on('close', () => {
      console.log(`${y}Goodbye.${rst}`);
      resolve();
    });
  });
}

function printBanner(termColors = {}) {
  const { yellow: y = '', reset: rst = '' } = termColors;

  const message = 'A Curious Fraction Tree';

  const underline = '='.repeat(message.length);

  console.log(`${y}${message}`);
  console.log(`${underline}${rst}`);
}

/*******************************************************************************
 * Main ************************************************************************
 ******************************************************************************/

(async function main() {
  try {
    printBanner(colors);
    await repl(colors);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
})();
