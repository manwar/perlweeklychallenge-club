# [Perl Weekly Challenge - 133] _JavaScript Edition_


**Trigger warning:** There's lots of math in this week's challenges.  Recovering
math addicts may want to avoid these solutions.  Personally, I've always been
more  the "hooked on phonics" type, so it was fun brushing up on some of these 
mathematical concepts as I worked through my solutions.

## Task 1 > Integer Square Root

You are given a positive integer `$N`.

Write a script to calculate the integer square root of the given number.

Please avoid using built-in function.  Find out more about it [here].

**Examples**

```
Input: $N = 10
Output: 3

Input: $N = 27
Output: 5

Input: $N = 85
Output: 9

Input: $N = 101
Output: 10
```

### Solution

I wasn't familiar with the idea of integer square roots, but after checking out
the linked Wikipedia reference ([here]), I found that the term is equivalent to
the largest integer square root that is less than or equal to our given input
(a square root floor, so to speak.  There are likely more elegant, mathematical
approaches to this problem, but my approach was to just start at 0 and check
incrementing squares until I exceeded the input.

```javascript

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

```

#### `ch-1.js`

Generally, I try to write a little test runner and some test cases, but in this
case, it felt like overkill, so instead running `./ch-1.pl` initiates a mini
REPL.  Writing a REPL with Node is a lot of fun.  Instead of the perlish
`while (<>)` style of handling user input, Node's `readline` is event-driven. 
The REPL prompts for input and returns the integer square root.  Sample output
is shown below:

```
$> ./ch-1.js

==============================
Integer Square Root Calculator
==============================

Enter a positive integer (or, type "exit" to quit)> 10
Integer square root: 3
Try again? (y/n)> y
Enter a positive integer (or, type "exit" to quit)> 27
Integer square root: 5
Try again? (y/n)> y
Enter a positive integer (or, type "exit" to quit)> 85
Integer square root: 9
Try again? (y/n)> y
Enter a positive integer (or, type "exit" to quit)> 101
Integer square root: 10
Try again? (y/n)> n
Goodbye.

```

## Task 2 > Smith Number

Write a script to generate the first 10 `Smith Numbers` in base 10.

According to Wikipedia:

> In number theory, a Smith number is a composite number for which, in a given
> number base, the sum of its digits is equal to the sum of the digits in its
> prime factorization in the given number base.

### Solution

At first, the language of this challenge had me feeling a little out of my
depths.  But, breaking down the problem, I realized that it wasn't as
complicated as I had initially believed.  It was clear that I needed a
subroutine to reduce a given number to its prime factors, a subroutine to
reduce a number to the sum of its digits, and that between those two functions,
I could find these "Smith Numbers."  Admittedly, my first solutions were all
incorrect as I glazed right over that phrase "composite number," which, I've
since learned, is a fancy way of saying "ain't prime."

```javascript

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

```

### `ch-2.js`

Again, this didn't feel like a situation for writing a bunch of tests, as I
wasn't sure the solution even worked until I compared the output against a list
of `Smith Numbers` I found online, so running `./ch-2.js` will output the first
10 `Smith Numbers` without much in the way of pomp or circumstance.  Optionally,
you can run `./ch-2.js` with a number argument to display more or less `Smith
Numbers` (i.e., `./ch-2.js 100` to return the first 100 `Smith Numbers`).
Sample output is shown below:

```
$> ./ch-2.js 10
The first 10 Smith Numbers are 4, 22, 27, 58, 85, 94, 121, 166, 202, and 265.
```

## Closing

I had a lot of fun with these challenges and picked up a little bit of math that
I might have otherwise avoided like the plague.  Thanks again, PWC.

[Perl Weekly Challenge - 133]: https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
[here]: https://en.wikipedia.org/wiki/Integer_square_root
