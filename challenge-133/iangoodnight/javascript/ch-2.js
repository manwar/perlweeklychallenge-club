#!/usr/bin/env node
// ch-2.js

/**
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
 *
 * Task 2 > Smith Numbers
 * ======================
 *
 * Write a script to generate the first 10 `Smith Numbers` in base 10.
 *
 * According to Wikipedia:
 *
 * > In number theory, a Smith number is a composite number for which, in a
 * > given number base, the sum of its digits is equal to the sum of the digits
 * > in its prime factorization in the given number base.
 *
 **/

'use strict';

/**
 * Our PWC solution and some helper functions
 **/

// First, we need a utility function to return our prime factors
function primeFactors(number) {
  let n = parseInt(number, 10); // Input validation
  if (number === 'NaN') {
    // Fail fast if arg is not a positive integer
    throw new Error(
      'function `primeFactors` expects a positive integer as an argument.',
    );
  }
  const factors = [];

  let divisor = 2; // Starting with 2, check for remainder
  while (n >= 2) {
    if (n % divisor === 0) {
      // If modulo is 0, push to factors
      factors.push(divisor);
      n /= divisor;
    } else {
      divisor += 1; // Else, increment the divisor and try again
    }
  }
  return factors;
}

// Reduce numbers to the sum of their digits
function sumDigits(number) {
  return number
    .toString()
    .split('')
    .reduce((sum, digit) => sum + parseInt(digit, 10), 0);
}

// Find our actual smith numbers with the help of `primeFactors` and `sumDigits`
function identifySmithNumbers(limit = 10) {
  const smithNumbers = [];

  let test = 4; // Smith numbers are composite numbers, so skip the primes
  while (smithNumbers.length < limit) {
    const primeFactorsArr = primeFactors(test);

    const factorSum = primeFactorsArr.reduce(
      (sum, factor) => sum + sumDigits(factor),
      0,
    );

    const digitSum = sumDigits(test);

    if (factorSum === digitSum && primeFactorsArr.length !== 1) {
      smithNumbers.push(test);
    }
    test += 1;
  }
  return smithNumbers;
}

/**
 * General utilities
 **/

// Takes an array and returns it as human-readable comma separated list
function stringWithOxfordComma(arr = []) {
  const reversed = [...arr].reverse();

  const [last, ...rest] = reversed;

  const first = [...rest].reverse().join(', ');

  return `${first}, and ${last}`;
}

// IIFE to handle args and print results
(function main() {
  const limit = process.argv[2] || 10;

  const smithNumbers = identifySmithNumbers(limit);

  const stringified = stringWithOxfordComma(smithNumbers);

  console.log(`The first ${limit} Smith Numbers are ${stringified}.`);
})();
