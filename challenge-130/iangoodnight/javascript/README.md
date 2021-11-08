# Perl Weekly Challenge Club - 130

I've been having a lot of fun with the PWC the last couple weeks.  Last week we
played with Linked Lists and Tree data structures.  I was passingly familiar 
with both of the concepts but hadn't implemented them myself.  Writing a Tree
class really opened my eyes to exactly how the DOM operates in a web browser.

This week, we had a list reducing challenge and a Binary Search Tree challenge.
The Binary Search Tree is another new data structure for me, so I was excited to
tackle it.  But first, our list reducer.

## Task 1 > Odd Number

You are given an array of positive integers, such that all the numbers appear
an even number of times except one number.

Write a script to find that integer.

**Example 1**

```javascript

const input = [2, 5, 4, 4, 5, 5, 2];

const output = 5; // as it appears 3 times in the array whereas all other
                  // numbers 2 and 4 appear exactly twice

```

**Example 2**

```javascript

const input = [1, 2, 3, 4, 3, 2, 1, 4, 4];

const output = 4;

```

### Solution

With just a couple extra steps, we can write our function to handle almost any
input and deal with cases with more than one answer.  Normally we would take the
challenge more literally, but since it doesn't seem to detract from anything to
extend our interface, we might as well design it to handle more test cases.

```javascript

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

```

### ch-1.js

Running `./ch-1.js` tests our solution against the sample test cases found at
`../test_cases/ch-1/`.  Optionally, `./ch-1.js` can be run with a path argument,
pointing to a test file or directory of test files (ie: `./ch-1.js ./test`).
Test files must be formatted as comma separated lists in the format:

```
Input list
expected output

# lines beginning with '#' and empty line are ignored
# a single file can contain multiple tests

1, 2, 2, 3, 3
1

# Whitespace optional

a,a,a,a,b,b,c
c
```

#### Output

Running `./ch-1.js` without arguments outputs our sample test results:

```
../test_cases/ch-1/case-1.txt
=====================================

Input: 2, 5, 4, 4, 5, 5, 2
Expected: 5
Result: 5
Passed ⚐


../test_cases/ch-1/case-2.txt
=====================================

Input: 1, 2, 3, 4, 3, 2, 1, 4, 4
Expected: 4
Result: 4
Passed ⚐


../test_cases/ch-1/case-3.txt
=====================================

Input: 3, 7, 7, 9, 9, 3, 2
Expected: 2
Result: 2
Passed ⚐

Input: 1, 1, 1, 1, 3
Expected: 3
Result: 3
Passed ⚐


../test_cases/ch-1/case-4.txt
=====================================

Input: 2, 7, 3, 3, 7, 7
Expected: 2, 7
Result: 2, 7
Passed ⚐


../test_cases/ch-1/case-5.txt
=====================================

Input: 1, H, H, H, 1, tree, tree
Expected: H
Result: H
Passed ⚐

Input: 😼, 😽, 😽
Expected: 😼
Result: 😼
Passed ⚐

Input: -2, -2, 10, 10, 10, 10, -1
Expected: -1
Result: -1
Passed ⚐


```

## Task 2 > Binary Search Tree

You are given a tree.  Write a script to find out if the given tree is a
`Binary Seach Tree (BST)`.  According to wikipedia, the definition of BST:

> A binary search tree is a rooted binary tree, whose internal nodes each
> store a key (and optionally, an associated value), and each had two
> distinguished sub-trees, commonly denoted left and right.  The tree
> additionally satisfies the binary seach property: the key in each node is
> greater than or equal to any key stored in the left sub-tree, and less than
> or equal to any key stored in the right sub-tree.  The leaves (final nodes)
> of the tree contain no key and have no structure to distinguish them from
> one another.

**Example 1**

```

Input:

    8
   / \
  5   9
 / \
4   6

Output: 1 as the given tree is a BST.

```

**Example 2**

```

Input:

    5
   / \
  4   7
 / \
3   6

Output: 0 as the given tree is not a BST.

```

### Solution

The real fun here was dealing with an interesting data structure, Binary Search
Tree and figuring out a good way to parse text into binary trees. 

```javascript

function isBST(binaryTree = {}) {
  // Guard against obviously bad input
  if (typeof binaryTree !== 'object' || !binaryTree.root) return false;
  // This is our actual solution, `isBST` is just a wrapper for it
  const recurse = ((node, min = null, max = null) => {
    // if no node, we've reached the end of the tree without failing.  Pass.
    if (!node) return true;
    // if we've exceed our max, fail
    if (max !== null && node.data >= max) return false;
    // if we find a value less than our min, fail
    if (min !== null && node.data <= min) return false;
    // Recurse through the rest of the nodes.
    return (
      recurse(node.left, min, node.data) &&
      recurse(node.right, node.data, max)
    );
  });
  // Start recursion at the validated root
  return recurse(binaryTree.root);
}

```

We are going to test our solution against a `BinaryTree` class that uses a 
`BinaryNode` class as a helper.

```javascipt

// BinaryNode and BinaryTree classes to build test cases
class BinaryNode {
  constructor(data) {
    this.data = data;
  }
  // addRight and addLeft methods to keep our nodes binary and our leaves clear
  addRight(data) {
    if (this.right) return false;
    this.right = new BinaryNode(data);
    return this;
  }

  addLeft(data) {
    if (this.left) return false;
    this.left = new BinaryNode(data);
    return this;
  }
}

class BinaryTree {
  constructor(data = null) {
    if (data !== null) {
      this.root = new BinaryNode(data);
    } else {
      this.root = data;
    }
  }
  // In the case where Binary tree is initialized without a root or when
  // over-writing an existing tree.
  addRoot(data) {
    if (!data) return false;
    this.root = new BinaryNode(data);
  }
  // Private crawl method
  #crawl(callback) {
    const recurse = (node) => {
      callback(node);
      if (node.left) recurse(node.left);
      if (node.right) recurse(node.right);
    }
    recurse(this.root);
  }
  // Find and return a node by data value to assist in building our tree
  findNode(data) {
    let found = false;
    this.#crawl((node) => {
      if (node.data === data) {
        found = node;
        return;
      }
    });
    return found;
  }
}

```

### ch-2.js

Running `./ch-2.js` tests our solution against the sample test cases found at
`../test_cases/ch-2/`.  Optionally, `./ch-2.js` can be run with a path argument,
pointing to a test file or directory of test files (ie: `./ch-2.js ./test`). 
Test files are parsed and constructed using our `BinaryTree` class.  Figuring
out a way to parse the input was a lot of fun, but there are probably better 
ways to do it.  Basically, the input is as shown in the challenge description
with nodes attached to leaves with `/` or `\`.  The parser will read trees as
long as their leaves don't overlap their parents.  So:

```
    5
   / \
  4   7
 / \
3   6
```

...parses correctly and

```
         5
    /      \
   4          7
  /   \
3      6

```

...parses, but

```
      5
     / \
    4   7 # overlaps leaf
 / \
3   6

```

...does not.

Test cases are comprised of trees (drawn as shown in the examples above) and 
outputs formatted as:

```
Output: 0
```

...for negative tests and

```
Output: 1
```

...for positive tests.

Test files may contain multiple tests, lines beginning with `#` will be ignored.
See sample tests at `../test_cases/ch-2/` for further examples.

#### Output

Running `./ch-2.js` without arguments outputs our sample test results:

```

../test_cases/ch-2/case-1.txt
===============================================

Input:
    8
   / \
  5   9
 / \
4   6
Expected: 1
Result: 1 as the given tree is a BST.
Passed ⚐

../test_cases/ch-2/case-2.txt
===============================================

Input:
    5
   / \
  4   7
 / \
3   6
Expected: 0
Result: 0 as the given tree is not a BST
Passed ⚐

../test_cases/ch-2/case-3.txt
===============================================

Input:
    h
   / \
  e   i
 / \
d   f
Expected: 1
Result: 1 as the given tree is a BST.
Passed ⚐

Input:
    e
   / \
  d   g
 / \
c   f
Expected: 0
Result: 0 as the given tree is not a BST
Passed ⚐

../test_cases/ch-2/case-4.txt
===============================================

Input:
      10
     /     \
  7         11
 /  \
6    8
Expected: 1
Result: 1 as the given tree is a BST.
Passed ⚐

Input:
                 f
              /      \
          e            h
        /   \
d              g
Expected: 0
Result: 0 as the given tree is not a BST
Passed ⚐

../test_cases/ch-2/case-5.txt
===============================================

Input:
          1011
         /      \
    83.1          1011.11
  /     \
-2       99.99
Expected: 1
Result: 1 as the given tree is a BST.
Passed ⚐


```
