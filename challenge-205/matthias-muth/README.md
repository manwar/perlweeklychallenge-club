# Challenge 205 solutions by Matthias Muth

## Task 1: Third Highest

> You are given an array of integers.<br/>
Write a script to find out the _Third Highest_ `if` found otherwise return the maximum.

Thinking about a solution I start at the end:<br/>
I imagine simply getting the result from the ordered list of input values -- just take the third value, and it there isn't any, take the first. So sort and return -- easy!

But what if there are values that exist several times in the array? Actually we need to do a Unix style ``sort | uniq`` instead of just ``sort``.

### `Uniq` anyone? 

I recommend brian d foy's very nice contribution _How can I remove duplicate elements from a list or array?_ in the [Perl FAQ](https://perldoc.perl.org/perlfaq4#How-can-I-remove-duplicate-elements-from-a-list-or-array?).
These are his suggestions:
* Use a hash. Like for example:
```perl
my %hash   = map { $_, 1 } @array;
# or a hash slice: @hash{ @array } = ();
# or a foreach: $hash{$_} = 1 foreach ( @array );

my @unique = keys %hash;
```

The problem with this is that elements are returned in random order, completely unsorted. This means we would _first_ need to do the `unique` step, and _then_ the `sort`.
But now I want to know how to do a better `uniq`!

* Try the `uniq` function in ``List::MoreUtils``. 

It's a pity that that module is not part of the core perl distribution, and I don't want to ask people to install CPAN modules just for getting the third highest of 3 or 4 numbers. :-)

* Use a hash for remembering those elements that we have seen already. In the short version:

```perl
my %seen = ();
my @unique = grep { ! $seen{ $_ }++ } @array;
```
This keeps the order of elements intact, it only removes those that we already have.<br/>
This looks good!

### But `uniq` is in `List::Util`, too, now!

As I was gathering ideas for other solutions using the `reduce` or `reductions` functions
from `List::Util`
(which *is* a core module!),
I stumbled over the `uniq` function right there!

`Uniq`has been in `List::Util` since its version 1.44 (see [here](https://metacpan.org/dist/Scalar-List-Utils/changes)), which is part of perl version 5.25.1 (according to `$ corelist List::Util 1.44`), which was released on 2016-05-20 (using `$ corelist -r 5.25.1`).

So for more recent versions of perl this the solution is this:

```perl
use v5.25.1;
use strict;
use warnings;

use List::Util qw( uniq );

sub third_highest {
    my @a = uniq reverse sort @_;
    return @a >= 3 ? $a[2] : $a[0];
}
```

If only an older perl version is available, we still can use this:

```perl
use strict;
use warnings;

sub uniq {
    my %seen;
    return grep { ! $seen{$_}++ } @_;
}

sub third_highest {
    my @a = uniq reverse sort @_;
    return @a >= 3 ? $a[2] : $a[0];
}
```
 

## Task 2: Maximum XOR

>

Thank you for the challenge!
