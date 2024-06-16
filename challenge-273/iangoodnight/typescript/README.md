# Perl Weekly Challenge - 273

Welcome to [Week #273][0] of [The Weekly Challenge][1].

## Task 1: Percentage of Character

**Submitted by:** [Mohammad Sajid Anwar][2]

You are given a string, `$str` and a character `$char`.

Write a script to return the percentage, nearest whole, of given character in
the given string.

**Example 1**

```
Input: $str = "perl", $char = "e"
Output: 25
```

**Example 2**

```
Input: $str = "java", $char = "a"
Output: 50
```

**Example 3**

```
Input: $str = "python", $char = "m"
Output: 0
```

**Example 4**

```
Input: $str = "ada", $char = "a"
Output: 67
```

**Example 5**

```
Input: $str = "ballerina", $char = "l"
Output: 22
```

**Example 6**

```
Input: $str = "analitik", $char = "k"
Output: 13
```

### Solution

Our solution is implemented in the [task1.ts][3] file. The solution provides a
single function, `percentageOfCharacter`, that takes two arguments: a string and
a character. The function calculates the percentage of the character in the
string and returns the nearest whole number.

```typescript
// the factor to convert a decimal to a percentage
const PERCENTAGE_FACTOR = 100;

function percentageOfCharacter(str: string, char: string): number {
  // the length of the string becomes the denominator
  const length = str.length;
  // the count of the character becomes the numerator
  const characters = str.split('');
  // filter the characters that match the given character
  const matchingCharacters = characters.filter((c) => c === char);
  // count the matching characters
  const matchingCharactersCount = matchingCharacters.length;
  // calculate the percentage
  const decimalPercentage = matchingCharactersCount / length;
  // convert the percentage to a number out of 100
  const percentage = decimalPercentage * PERCENTAGE_FACTOR;
  // round the percentage to the nearest whole number
  const roundedPercentage = Math.round(percentage);
  // return the rounded percentage
  return roundedPercentage;
}
```

This solution could be a lot shorter. For example we could write it in far
fewer lines like this:

```typescript
const percentageOfCharacter = (str: string, char: string): number => {
  return Math.round(
    (str.split('').filter((c) => c === char).length / str.length) * 100,
  );
};
```

However, we chose to write it in a more verbose manner to make it easier to read
and follow along with the logic. In general, code that is written in a more
declarative style is easier to maintain and understand.

### Testing

We have included a test suited found in the `__tests__` directory. The test
relies on `jest` to run. If you do not have the `jest` package installed
globally, you can install from our `package.json`. Also included is our
`jest.config.js` file which sets up some typescript specific configurations for
jest.

```bash
npm install --only=dev
```

Our test script takes the example inputs from the problem statement and asserts
that the output matches the expected output.

```typescript
import percentageOfCharacter from '../task1';

test('Task 1: Percentage of Character', () => {
  expect(percentageOfCharacter('perl', 'e')).toBe(25);
  expect(percentageOfCharacter('java', 'a')).toBe(50);
  expect(percentageOfCharacter('python', 'm')).toBe(0);
  expect(percentageOfCharacter('ada', 'a')).toBe(67);
  expect(percentageOfCharacter('ballerina', 'l')).toBe(22);
  expect(percentageOfCharacter('analitik', 'k')).toBe(13);
});
```

Assuming you have `jest` available, or that you have installed from our
`package.json`, you can run the test script like so:

```bash
# npm test will match against whatever argument is passed as a regex.  here, we
# point to the test file for task 1.
npm test 273/__tests__/task1.test.ts
```

## Task 2: B After A

**Submitted by:** [Mohammad Sajid Anwar][2]

You are given a string, `$str`.

Write a script to return `true` if there is at least one `b`, and no `a` appears
after the first `b`.

**Example 1**

```
Input: $str = "aabb"
Output: true
```

**Example 2**

```
Input: $str = "abab"
Output: false
```

**Example 3**

```
Input: $str = "aaa"
Output: false
```

**Example 4**

```
Input: $str = "bbb"
Output: true
```

### Solution

Our solution is implemented in the [task2.ts][4] file. The solution provides a
single function, `bAfterA`, that takes a single argument: a string. The function
returns a boolean value indicating whether the string contains at least one `b`
and no `a` appears after the first `b`.

```typescript
function bAfterA(str: string): boolean {
  // the regular expression checks for the presence of a `b` followed by any
  // number of characters that are not `a`
  // /         - start of the regular expression
  // ^         - start of the string
  // [^b]*     - any number of characters that are not `b`
  // b         - at least one `b`
  // [^a]*     - any number of characters that are not `a` (even not `b`)
  // $         - end of the string
  // /         - end of the regular expression
  return str.match(/^[^b]*b+[^a]*$/) !== null;
}
```

We could have just as easily used the `RegExp.test` method to check for a match
and return a boolean value. The `RegExp.test` method returns `true` if the
regular expression matches the string, and `false` otherwise. Our regular
expression could arguably be simplified to `/b[^a]*$/` to achieve the same
result, but we chose to be more explicit in our pattern.

### Testing

We have again included a test suite found in the `__tests__` directory. The test
relies on `jest` to run. If you do not have the `jest` package installed
globally, you can install from our `package.json` (if you didn't install it
previously).

```bash
npm install --only=dev
```

Our test script takes the example inputs from the problem statement and asserts
that the output matches the expected output.

```typescript
import bAfterA from '../task2';

describe('Task 2: B After A', () => {
  test('Example 1', () => {
    expect(bAfterA('aabb')).toBe(true);
  });

  test('Example 2', () => {
    expect(bAfterA('abab')).toBe(false);
  });

  test('Example 3', () => {
    expect(bAfterA('aaa')).toBe(false);
  });

  test('Example 4', () => {
    expect(bAfterA('bbb')).toBe(true);
  });
});
```

Assuming you have `jest` available, or that you have installed from our
`package.json`, you can run the test script like so:

```bash
# npm test will match against whatever argument is passed as a regex.  here, we
# point to the test file for task 2.
npm test 273/__tests__/task2.test.ts
```

You can run both test suites at once by running `npm test 273` which will run
both test suites for Task 1 and Task 2.

[0]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-272/
[1]: https://perlweeklychallenge.org
[2]: https://manwar.org/
[3]: ./task1.ts
[4]: ./task2.ts
