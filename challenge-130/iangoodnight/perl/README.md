# Perl Weekly Challenge Club - 130

I started late the last two weeks and finished JavaScript solutions for the PWC
but ran out of time before I finished my Perl Solutions.  Still, I learned a lot
in the attempts, and it was a great excuse to play with some data structures I
wasn't very familiar with.  I was glad to see the Binary Search tree show up
this week after playing with Binary trees last week, as it gave me another
chance to work a little with writing object-oriented perl (if not in my
solutions, at least in framing the problem initially).  Thanks, and great job
with the challenges team PWC!

## Task 1 > Odd Number

You are given an array of positive integers, such that all the numbers appear
an even number of times except one number.

Write a script to find that integer.

**Example 1**

```perl

@input = (2, 5, 4, 4, 5, 5, 2);

$output = 5; # as it appears 3 times in the array whereas all other numbers 2
             # and 4 appear exactly twice
```

**Example 2**

```perl

@input = (1, 2, 3, 4, 3, 2, 1, 4, 4);

$output = 4;

```

### Solution

I'm on a real declarative coding kick, so this is a little more verbose than
necessary, but hopefully, as I do more of these challenges, I'll pick up some
more perlish idioms and shortcuts.

```perl
  
sub reduce_to_odd {
  my $input_ref = shift;
  my %mapped;
  # First, we reduce our input to a hash of values and counts
  foreach my $entry (@$input_ref) {
    # If entry exists, increment count
    if (exists $mapped{$entry}) {
      $mapped{$entry}++;
      next;
    }
    # Else, initialize count
    $mapped{$entry} = 1;
  }
  # Technically, our challenge states that there will only ever be one odd input
  # count, but, just for fun, we'll design it to return all odd counts in case
  # we get improperly validated input.
  my @odd;
  foreach my $key (keys %mapped) {
    # Iterate through, pushing values with odd counts to our `odd` array
    if ($mapped{$key} % 2 != 0) {
      push(@odd, $key);
    }
  }
  my $result_count = scalar @odd;
  # Handle our possible results:
  if ($result_count == 0) {
    # Tricky input, no correct answer.
    return 'No odd counts found';
  }
  if ($result_count == 1) {
    # Input as expected, return correct answer
    return $odd[0];
  }
  # Incorrectly validated input.  Be the bigger person and just return all
  # correct answers as a reference to our `odd` array.
  return \@odd;
}

```

### ch-1.pl

Running `./ch-1.pl` tests our solution against the sample test cases found at
`../test_cases/ch-1/`.  Optionally, `./ch-1.pl` can be run with a path argument,
pointing to a test file or directory of test files (ie: `./ch-1.pl ./test`).
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

Running `./ch-1.pl` without arguments outputs our sample test results:

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
Tree, writing some object-oriented perl to create test trees, and figuring out a
good way to parse text into binary trees.  I had run into some obstacles
figuring out how to handle writing classes with Perl last week, but I think I am
getting the hang of it now.

```perl

sub is_BST {
  my ($tree, $node, $min, $max) = @_;
  # catch invalid input, reset at root
  if (not ($node || $min || $max)) {
    return 0 unless $tree->{'root'};
    return is_BST($tree, $tree->{'root'});
  }
  # if no node, we've reached the end of the tree.  pass
  if (($min || $max) and not (defined $node)) {
    return 1;
  }
  # Testing conveniences
  my $test = $node->{'data'};
  my $num = $test =~ /^-?\d*\.?\d+$/;
  # exceeds $max.  fail
  if (defined $max) {
    if ($num and $test >= $max) {
      return 0;
    }
    if (not($num) and $test ge $max) {
      return 0;
    }
  }
  # less then $min.  fail
  if (defined $min) {
    if ($num and $test <= $min) {
      return 0;
    }
    if (not($num) and $test le $min) {
      return 0;
    }
  }
  # recurse
  if (
    is_BST($tree, $node->{'left'}, $min, $node->{'data'}) &&
    is_BST($tree, $node->{'right'}, $node->{'data'}, $max)
  ) {
    # pass
    return 1;
  }
  # something unexpected happened, fail for safety
  return 0;
}

```

We are going to test our solution against a `Binary_tree` class that uses a
`Binary_node` class as a helper.

```perl

{
  # Binary_node class to expose `add_right` and `add_left` methods
  package Binary_node;
  # constructor
  sub new {
    my $class = shift;
    my $self = {
      data => shift
    };
    bless $self, $class;
    return $self;
  }

  sub add_left {
    my ($self, $data) = @_; 

    if (exists $self->{'left'}) {
      return 0;
    }
    $self->{'left'} = Binary_node->new($data);
    return $self;
  }

  sub add_right {
    my ($self, $data) = @_;

    if (exists $self->{'right'}) {
      return 0;
    }
    $self->{'right'} = Binary_node->new($data);
    return $self;
  }
}

{
  package Binary_tree;
  # constructor
  sub new {
    my $class = shift;
    my $data = shift;
    my $self = {
      root => undef
    };
    if (defined $data) {
      $self->{'root'} = Binary_node->new($data);
    }
    bless $self, $class;
    return $self;
  }
  # In the case where the Binary_tree is initialized without a root
  sub add_root {
    my ($self, $data) = @_;

    if (defined $data) {
      $self->{'root'} = Binary_node->new($data);
      return $self;
    }
    return 0;
  }
  # Find and return a node to assist in building our tree
  sub find_node {
    my ($self, $match, $tree) = @_;
    unless (defined $tree) {
      $tree = $self->{'root'};
    }
    if ($tree->{'data'} eq $match) {
      return $tree;
    }
    unless ($tree->{'left'} || $tree->{'right'}) {
      return 0;
    }
    return find_node($self, $match, $tree->{'left'}) ||
           find_node($self, $match, $tree->{'right'});
  }
}

```

### ch-2.pl

Running `./ch-2.pl` tests our solution against the sample test cases found at
`../test_cases/ch-2/`.  Optionally, `./ch-2.pl` can be run with a path argument,
pointing to a test file or directory of test files (ie: `./ch-2.pl ./test`). 
Test files are parsed and constructed using our `Binary_tree` class.  Figuring
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

Running `./ch-2.pl` without arguments outputs our sample test results:

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
