#!/usr/bin/env node
// ch-1.js

/*******************************************************************************
 * https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
 *
 * ## Task 1 > 10001st Prime Number
 * ================================
 *
 * Write a script to generate the 10001st prime number.
 ******************************************************************************/

'use strict';

/*******************************************************************************
 * PWC Solution ****************************************************************
 ******************************************************************************/

function getPrime(numPrime = 10001) {
  const primes = [2, 3];

  const limit = parseInt(numPrime, 10);

  const isPrime = (n) =>
    !primes.some(
      (prime) => prime <= Math.floor(Math.sqrt(n)) && n % prime === 0,
    );

  let num = 5;

  while (primes.length < limit) {
    if (isPrime(num)) primes.push(num);
    num += 2;
  }

  return primes.slice(-1)[0];
}

/*******************************************************************************
 * Utilities *******************************************************************
 ******************************************************************************/

function getSuffix(num) {
  const lastDigit = parseInt([...num.toString()].pop(), 10);

  if (lastDigit === 0 || lastDigit >= 4) return 'th';
  if (lastDigit === 1) return 'st';
  if (lastDigit === 2) return 'nd';
  if (lastDigit === 3) return 'rd';
  return '';
}

const colors = {
  yellow: '\x1b[33m',
  green: '\x1b[32m',
  reset: '\x1b[0m',
};

/*******************************************************************************
 * Main ************************************************************************
 ******************************************************************************/

(function main() {
  const nth = process.argv[2] || 10001;

  const prime = getPrime(nth);

  const suffix = getSuffix(nth);

  const { yellow: y, green: g, reset: r } = colors;

  console.log(`The ${y + nth + suffix + r} prime number is: ${g + prime + r}`);
})();
