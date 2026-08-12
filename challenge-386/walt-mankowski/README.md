Solutions by Walt Mankowski.

# Perl Weekly Challenge #327: MAD About Missing Integers

I did this week's challenges in Perl and Python.

Just a note that for each problem, I read the input via command line
arguments, and I don't do any error checking. Of course I wouldn't do
that in the real world, but here I just wanted to focus on the
algorithms and language features.

## Task #1: Missing Integers

For this task we're given an array of `n` integers, and we need to
report on any integers in the range `1..n` that are missing.

In Perl I start by making a hash where the keys are all the values
from 1 to the length of the array, which is `@ARGV`. I don't care
about the values so I set them all to 1. I delete any elements that
are given in the list, and finally I print out all the keys that
remain in the hash.

```perl
# make a hash of all the possible values from 1 to @ARGV
my %missing = map { $_ => 1 } 1..@ARGV;

# delete any elements in @ARGV
delete $missing{$_} for @ARGV;

# print out any remaining keys
printf "(%s)\n", join ", ", sort { $a <=> $b } keys %missing;
```

In Python this is easier since we can use the set type and do
everything in a one-liner. Just make one set with all the possible
values, another with the elements in the array, and find the set
difference.

```python
from sys import argv

missing = set(range(1, len(argv))) - set(map(int, argv[1:]))
print(missing)
```

## Task #2: MAD

For this task we're given an array of distinct integers. We need to
consider all the possible pairs in the array, compute the absolute
value of their differences, then print all the pairs which have a
Minimum Absolute Difference (MAD).

To solve this I use two variables: the smallest difference I've
already seen (which I initialize to a huge number) and a list of all
the pairs with that difference. I also sort the list. This isn't
strictly necessary, but it ensures that when I print out the pairs the
smaller number will always be first.

```perl
my $min_dist = 1e300;
my @pairs;
my @elements = sort { $a <=> $b } @ARGV;
```

Then I have two nested for loops that do all the bookkeeping:

```perl
for my $i (0..$#elements-1) {
    for my $j ($i+1..$#elements) {
        my $delta = abs($elements[$i] - $elements[$j]);
        if ($delta < $min_dist) {
            @pairs = ([$elements[$i], $elements[$j]]);
            $min_dist = $delta;
        } elsif ($delta == $min_dist) {
            push @pairs, [$elements[$i], $elements[$j]];
        }
    }
}
```

Finally I print them out nicely:

```perl
for my $i (0..$#pairs) {
    printf "[%d,%d]", $pairs[$i][0], $pairs[$i][1];
    print ", " if $i < $#pairs;
}
say "";
```

There are two main differences in my Python code:
* I saved one level of nested loops by using `itertools.combinations`.
* Python does a better job of printing out nested lists than Perl
  does, so I can just say `print(pairs)` instead of doing all the work
  myself.

```python
from sys import argv
from itertools import combinations

min_dist = 1e300
pairs = []
elements = sorted(map(int, argv[1:]))

for i,j in combinations(range(len(elements)), 2):
    delta = abs(elements[i] - elements[j])
    if delta < min_dist:
        pairs = [[elements[i], elements[j]]]
        min_dist = delta
    elif delta == min_dist:
        pairs.append([elements[i], elements[j]])

print(pairs)
```
