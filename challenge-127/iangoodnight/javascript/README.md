
# Perl Weekly Challenge Club - 127

This is my first time submitting!  I had a lot of fun and it was a good excuse
to work on my Perl.  I spend most of my time working with Javascript, so I
started out by writing a solution Javascript.

## Task 1 > Disjoint Sets

You are given two sets with unique integers.
Write a script to figure out if they are disjoint.

The two sets are disjoint if they don't have any common members

### EXAMPLE

**Input:**

```javascript   
const s1 = [1, 2, 5, 3, 4];
const s2 = [4, 6, 7, 8, 9];
```

**Output:** `0` as the given sets have common member `4`.

**Input:**

```javascript 
const s1 = [1, 3, 5, 7, 9];
const s2 = [0, 2, 4, 6, 8];
```

**Output:** `1` as the given two sets do no have a common member.

### SOLUTION

```javascript
function isDisjoint(set1 = [], set2 = []) {
  const testSet = [...set1];           // shallow copy of the first set

  let disjoint = true;                 // trust, but verify
  while (disjoint && testSet.length) {
    const test = testSet.pop();
   if (set2.includes(test)) disjoint = false;
  }
  return disjoint;
}
```

### ch-1.js

Running `./ch-1.js` tests our solution against the following test cases, 
printing `Passed` or `Failed` to the console:

#### Case 1:

```javascript
1,2,5,3,4
4,6,7,8,9
0         // false, 4 is not unique
```

#### Case 2:

```javascript
1,3,5,7,9
0,2,4,6,8
1
```

#### Case 3:

```javascript
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
2
1         // Technically, the sets are still disjoint
```

#### Case 4:

```javascript
😺,😸,😹,😻,😼,😽
😽,🙀,😿,😾
0         // False
```

#### Case 5:

```javascript
🙂,🙃,😉,😌,😍,🥰,😘,😗,😙,😚,😋
🤤,😪,😵,🤐,🥴,🤢,🤮,🤧,😷,🤒,🤕
1         // True
```

### Custom Tests

`./ch-1.js` will optionally accept a path to a test file or directory of test
files (ie: `$ ./ch-1.js ./local_test.txt`).  Test files must include no more than
2 lines of comma separated values with the last line being either `0` for tests
that should fail or `1` for tests that should pass.  Lines beginning with `#` 
will be ignored.

## Task 2 > Conflict Intervals

You are given a list of intervals.
Write a script to find out if the current interval conflicts with any of the
previous intervals.

### EXAMPLE

**Input:**

```javascript
const intervals = [[1, 4], [3, 5], [6, 8], [12, 13], [3, 20]];
```

**Output:**

```javascript
[[3, 5], [3, 20]]
```

- The 1st interval `[1, 4]` does not have any previous intervals to compare
     with, so skip it.
- The 2nd interval `[3, 5]` does conflict with previous interval `[1, 4]`.
- The 3rd interval `[6, 8]` does not conflict with any of the previous
     intervals `[1, 4]` and `[3, 5]`, so skip it.
- The 4th interval `[12, 13]` again does not conflict with any previous
     intervals `[1, 4]`, `[3, 5]`, or `[6, 8]` so skip it.
- The 5th interval `[3, 20]` conflicts with the first interval `[1, 4]`.

**Input:** 

```javascript
const intervals = [[3, 4], [5, 7], [6, 9], [10, 12], [13, 15]];
```

**Output:**

```javascript
[[6, 9]];
```

### SOLUTION

```javascript
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
```

### ch-2.js

Running `./ch-2.js` tests our solution against the folowing test cases,
printing `Passed` or `Failed` to the console:


#### Case 1:

```javascript
{
  input: [[1, 4], [3, 5], [6, 8], [12, 13], [3, 20]],
  output: [[3, 5], [3, 20]]
}
```

#### Case 2:

```javascript
{
  input: [[3, 4], [5, 7], [6, 9], [10, 12], [13, 15]],
  output: [[6, 9]]
}
```

#### Case 3:

```javascript
{
  input: [[1.14, 1.56], [2.32, 3], [1.5, 1.72]],
  output: [[1.5, 1.72]]
}
```

#### Case 4:

```javascript
{
  input: [[-234, 10], [-1.12, 11], [11, 111111]],
  output: [[-1.12, 11]]
}
```

#### Case 5:

```javascript
{
  input: [[-1, -1], [1, 3], [3.1, 4], [4, 5]],
  output: [[4, 5]]
}
```

### Custom Tests

`./ch-2.js` will optionally accept a path to a test file or directory of test
files (ie: `$ ./ch-2.js ./local_test.json`).  Test files must be properly
formatted JSON with both an `"input"` and an `"output"` key.

#### Example Test

```json
{
  "input": [
    [
      1,
      3
    ],
    [
      2,
      4
    ],
    [
      6,
      7
    ]
  ],
  "output": [
    [
      2,
      4
    ]
  ]
}
```
