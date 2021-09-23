# [Perl Weekly Challenge - 131] _JavaScript Edition_

Five weeks into the Perl Weekly Challenge, my Perl is getting a lot sharper, but
I still have a lot of fun coming up with JavaScript solutions.  Generally
speaking, I try to make my code as declarative and self-documenting as possible,
however, the challenges this week are pretty straightforward, so I allowed
myself some room for solutions that I just dig aesthetically in my JavaScript
solutions this week.

# Task 1 > Consecutive Arrays

You are given a sorted list of unique positive integers.

Write a script to return lists of arrays where the arrays are consecutive
integers.

**Example 1:**

```javascript
const input = [1, 2, 3, 6, 7, 8, 9];

const output =[[1, 2, 3], [6, 7, 8, 9]];

```

**Example 2:**

```javascript
const input = [11, 12, 14, 17, 18, 19];

const output = [[2], [4], [6], [8]];

```

**Example 3:**

```javascript
const input = [2, 4, 6, 8];

const output = [[2], [4], [6], [8]];

```

**Example 4:**

```javascript
const input = [1, 2, 3, 4, 5];

const output = [[1, 2, 3, 4, 5]];

```

### Solution

When I am working with an array as input, my first question is, am I using
`map`, `filter`, `reduce`, or `forEach`, as these are functional operations
that,  between the four of them, are generally non-destructive and solve most use
cases.  Generally speaking, I am using a map if my output is meant to be an
`Array` the same length as my input, I am using `map`.  If my output is supposed
to be a shorter array, I'm probably going to reach for `filter`.  If my
operation calls for or causes side effects, `forEach` is probably the right
choice.  But, for anything else, I reach for `reduce`.  The general idea with
the `reduce` method to reduce an array to a single value like a `sum` or a `max`
value.  Really though, you can use reduce to return anything else that takes an
array as input.  Here, we use a `reduce` function to reduce our array to an
array of arrays as described in the examples above.

```javascript
// Task 1 Solution
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
```

The comments, though a little gratuitous, should make our operations clear.

### ch-1.js

Running `./ch-1.js` tests our solution against the sample test cases found at
`../test_cases/ch-1/`.  Optionally, `ch-1.js` can be run with a path argument
pointing to a test file or directory of test files (i.e., `./ch-1.js ./test`).
Our test files must be comprised of lines alternating between inputs and 
expected results formatted as shown in the examples above (i.e., `(1, 2, 4)` and
`([1, 2], 4)`). It looks a little funny in JavaScript, but this is the _Perl_
Weekly Challenge Club, after all.  Lines beginning with `#` and blank lines will
be ignored.  Lines are parsed with a helper function, `eval_input`.

```javascript
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

```

This function converts our Perlish input into arrays we can read into our
solution.

#### Output

Running `ch-1.js` with no arguments (assuming the existence of our sample
test directory) outputs:

```
../test_cases/ch-1/case-1.txt
=============================

Input: (1, 2, 3, 6, 7, 8, 9)
Expected: ([1, 2, 3], [6, 7, 8, 9])
Result: ([1, 2, 3], [6, 7, 8, 9])
Passed ⚐


../test_cases/ch-1/case-2.txt
=============================

Input: (11, 12, 14, 17, 18, 19)
Expected: ([11, 12], [14], [17, 18, 19])
Result: ([11, 12], [14], [17, 18, 19])
Passed ⚐


../test_cases/ch-1/case-3.txt
=============================

Input: (2, 4, 6, 8)
Expected: ([2], [4], [6], [8])
Result: ([2], [4], [6], [8])
Passed ⚐


../test_cases/ch-1/case-4.txt
=============================

Input: (1, 2, 3, 4, 5)
Expected: ([1, 2, 3, 4, 5])
Result: ([1, 2, 3, 4, 5])
Passed ⚐


../test_cases/ch-1/case-5.txt
=============================

Input: (-1, 0, 1, 11, 101, 102, 103)
Expected: ([-1, 0, 1], [11], [101, 102, 103])
Result: ([-1, 0, 1], [11], [101, 102, 103])
Passed ⚐

Input: (1, 2, 3, 7, 9)
Expected: ([1, 2, 3], [7], [9])
Result: ([1, 2, 3], [7], [9])
Passed ⚐
 
```

Our output shows all our tests as passing, indicating either that our solution 
is correct or our testing methods are flawed.

## Task 2 > Find Pairs

You are given a string of delimiter pairs and a string to search.

Write a script to return two strings, the first with any characters matching
the "opening character" set, the second with any matching the "closing 
character" set.

**Example 1:**

```
Input:

Delimiter pairs: ""[]()
Search String: "I like (parens) and the Apple ][+" they said.

Output:

  "(["
  "])"

```

**Example 2:**

```
Input:

Delimiter pairs: **//<>
Search String: /* This is a comment (in some languages) * / <could be a tag>

Output:

/**/<
/**/>

```

### Solution

From the examples provided, it looks like we are testing for _any_ instance of
our opening or closing delimiter, regardless of whether or not they are
fulfilling the function of opening or closing.  Specifically, matching tags like
`*`, `'`, or `"` will show up in both lines of output.  This makes for a simpler
solution, as we will not have to differentiate based on the actual function our
delimiters are serving (opening or closing).  We will partition our opening and
closing delimiters (again reaching for that flexible `reduce` function) assuming
that they are listed in pairs as shown in the example input (i.e.: `[]{}""`),
and then test our search string character-by-character via another `reduce`
function looking for matches.

```javascript
// Task 2 Solution
function findPairs(delimiters = '', string = '') {
  const [openSet, closeSet] = [...delimiters].reduce(
    ([open, close], el, idx) => {
      if (idx % 2) return [open, [...close, el]];
      return [[...open, el], close];
    },
    [[], []]
  );
  return [...string].reduce(
    ([open, close], el) => {
      if (openSet.includes(el)) open.push(el);
      if (closeSet.includes(el)) close.push(el);
      return [open, close];
    },
    [[], []]
  );
}

```

### `ch-2.js`

Generally speaking, when approaching these challenges, I have been consistently
writing a solution, creating a directory of test cases, and writing my
submission framed as a series of tests run against the solution.  So, in the
solution for the first task, running the file `ch-1.js` automatically looks for
that directory and those test cases unless it is run with a path argument
pointing to some other local test.  That choice was mainly just an excuse to
have some fun parsing different types of input files.  For `ch-2.js`, however,
the prospect of coming up with a bunch of delimiter tests cases seemed
dangerously boring.  So, instead, `ch-2.js` is written as an interactive CLI.
Running `./ch-2.js` starts our utility.  Sample output is shown below.

#### Output

```
$ ./ch-2.js
Welcome to delimiter search (type 'exit' or Ctrl+c to quit).
Please provide delimiter string (ie: ''[]{}<>**): ""[]()
Please provide search string: "I like (parens) and the Apple ][+" they said.
Results:
"(["
")]"
Welcome to delimiter search (type 'exit' or Ctrl+c to quit).
Please provide delimiter string (ie: ''[]{}<>**): **//<>
Please provide search string: /* This is a comment (in some languages) * / <could be a tag>
Results:
/**/<
/**/>
Welcome to delimiter search (type 'exit' or Ctrl+c to quit).
Please provide delimiter string (ie: ''[]{}<>**): exit"
```

## Coming Soon

Hopefully, by next week, I will be set up to start posting some of these on my
own, as of yet non-existent, blog.  It is my hope to explore programming in
general, using the PWC as an excuse to explore more `JavaScript`, `Perl`, and
hopefully some `Ruby`, `Bash`, and `Powershell` as well.  Stay tuned.


[Perl Weekly Challenge - 131]: https://theweeklychallenge.org/blog/perl-weekly-challenge-131/
