# Perl Weekly Challenge Club - 127

This is my first time submitting!  I had a lot of fun and it was a good excuse
to work on my Perl.

## Task 1 > Disjoint Sets

You are given two sets with unique integers.
Write a script to figure out if they are disjoint.

The two sets are disjoint if they don't have any common members

### EXAMPLE

**Input:**

```perl
@s1 = (1, 2, 5, 3, 4);
@s2 = (4, 6, 7, 8, 9);
```

**Output:** `0` as the given sets have common member `4`.

**Input:**

```perl
@s1 = (1, 3, 5, 7, 9);
@s2 = (0, 2, 4, 6, 8);
```

**Output:** `1` as the given two sets do no have a common member.

### SOLUTION

```perl
sub is_disjoint {
  my ($set1_ref, $set2_ref) = @_;                # Our two sets for comparison
  my @test_set = @$set1_ref;                     # Shallow copy
  my %haystack = map { $_ => 1 } @$set2_ref;     # Copy array values into a hash
  my $disjoint = 1;                              # Trust, but verify
  while ($disjoint and scalar @test_set) {       # Iterate through copy
    my $needle = pop(@test_set);                 
    $disjoint = 0 if exists($haystack{$needle}); # Test if disjoint
  }
  return $disjoint;
}
```

### ch-1.pl

Running `./ch-1.pl` tests our solution against the following test cases, 
printing `Passed` or `Failed` to the console:

#### Case 1:

```perl
1,2,5,3,4
4,6,7,8,9
0         # false, 4 is not unique
```

#### Case 2:

```perl
1,3,5,7,9
0,2,4,6,8
1
```

#### Case 3:

```perl
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
2
1         # Technically, the sets are still disjoint
```

#### Case 4:

```perl
😺,😸,😹,😻,😼,😽
😽,🙀,😿,😾
0         # False
```

#### Case 5:

```perl
🙂,🙃,😉,😌,😍,🥰,😘,😗,😙,😚,😋
🤤,😪,😵,🤐,🥴,🤢,🤮,🤧,😷,🤒,🤕
1         # True
```

### Custom Tests

`./ch-1.pl` will optionally accept a path to a test file or directory of test
files (ie: `$ ./ch-1.pl ./local_test.txt`).  Test files must include no more than
2 lines of comma separated values with the last line being either `0` for tests
that should fail or `1` for tests that should pass.  Lines beginning with `#` 
will be ignored.

## Task 2 > Conflict Intervals

You are given a list of intervals.
Write a script to find out if the current interval conflicts with any of the
previous intervals.

### EXAMPLE

**Input:**

```perl
@intervals = ( [1, 4], [3, 5], [6, 8], [12, 13], [3, 20] );
```

**Output:**

```perl
( [3, 5], [3, 20] )
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

```perl
@intervals = ( [3, 4], [5, 7], [6, 9], [10, 12], [13, 15] );
```

**Output:**

```perl
( [6, 9] );
```

### SOLUTION

```perl

sub find_conflict_intervals {
  my $set_ref = shift @_;
  my @conflicts = ();
  my @passed = ();
  if (reftype $set_ref ne "ARRAY") {
    print "Array reference not found\n";
    return 0;
  }
  foreach my $set (@$set_ref) {
    my ($a1, $a2) = sort { $a <=> $b } @$set;
    my $conflict = grep {
      my ($b1, $b2) = sort { $a <=> $b } @$_;
      ($a1 >= $b1 && $a1 <= $b2) ||
      ($a2 >= $b1 && $a2 <= $b2) ||
      ($a1 <= $b1 && $a2 >= $b2);
    } @passed;
    push @passed, [$a1, $a2] if not $conflict;
    push @conflicts, [$a1, $a2] if $conflict;
  }
  return \@conflicts;
}

```

### ch-2.pl

Running `./ch-2.pl` tests our solution against the folowing test cases,
printing `Passed` or `Failed` to the console:


#### Case 1:

```perl
{
  "input" => ([1, 4], [3, 5], [6, 8], [12, 13], [3, 20]),
  "output" => ([3, 5], [3, 20])
}
```

#### Case 2:

```perl
{
  "input" => ([3, 4], [5, 7], [6, 9], [10, 12], [13, 15]),
  "output" => ([6, 9])
}
```

#### Case 3:

```perl
{
  "input" => ([1.14, 1.56], [2.32, 3], [1.5, 1.72]),
  "output" => ([1.5, 1.72])
}
```

#### Case 4:

```perl
{
  "input" => ([-234, 10], [-1.12, 11], [11, 111111]),
  "output" => ([-1.12, 11])
}
```

#### Case 5:

```perl
{
  "input" => ([-1, -1], [1, 3], [3.1, 4], [4, 5]),
  "output" => ([4, 5])
}
```

### Custom Tests

`./ch-2.pl` will optionally accept a path to a test file or directory of test
files (ie: `$ ./ch-2.pl ./local_test.json`).  Test files must be properly
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
