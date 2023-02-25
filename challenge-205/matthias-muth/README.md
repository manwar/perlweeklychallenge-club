# Uniq anyone?
**Challenge 205 solutions in Perl by Matthias Muth**

## Task 1: Third Highest

> You are given an array of integers.<br/>
Write a script to find out the _Third Highest_ if found otherwise return the maximum.

Thinking about a solution I start at the end:<br/>
I imagine simply getting the result from the ordered list of input values -- just take the third value, and it there isn't any, take the first. So sort and return -- easy!

But what if there are values that exist several times in the array? Actually we need to do a Unix style ``sort | uniq`` instead of just ``sort``.

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

### But `uniq` is in `List::Util` now!

As I was gathering ideas for other solutions using the `reduce` or `reductions` functions
from `List::Util`
(which *is* a core module!),
I stumbled over the `uniq` function in the [`List::Util` documentation](https://perldoc.perl.org/List::Util#uniq)!

`Uniq` has been in `List::Util` since its version 1.44 (see [here](https://metacpan.org/dist/Scalar-List-Utils/changes)), which is part of perl version 5.25.1 (according to `$ corelist List::Util 1.44`), which was released on 2016-05-20 (using `$ corelist -r 5.25.1`).

So for more current versions of perl the solution can look like  this:

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

For older perl versions, we still can use this:

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

Great to have learned something from this challenge!

## Task 2: Maximum XOR

>You are given an array of integers.<br/>
>Write a script to find the highest value obtained by XORing any two distinct members of the array.

'*XORing any two distinct members of the array*' we can do by XORing the first element with all others following it, then the second one with the ones following that one, and and so on until we have done it for all elements.
For every element, we do not need to XOR it with the elements preceding it, because those values we already have (using the fact that XOR is a commutative operation, so `( $a[$i] ^ $a[$j] )` is the same as `( $a[$j] ^ $a[$i] )` ).
And actually we don't need to take care of the last element in the list, because it has no successors to XOR with.

So a straightforward solution looks like this:

```perl
sub max_xor {
    my @all_xors;
    for my $i ( 0 .. ( $#_ - 1 ) ) {
        for my $j ( $i..$#_ ) {
            push @all_xors, $_[$i] ^ $_[$j];
        }
    };
    return max( @all_xors );
}
```

Ok. Very boring.

But we can replace the inner loop by a `map` call, to push all XOR results of one element in one operation. Like so:

```perl
sub max_xor_2 {
    my @all_xors;
    for my $i ( 0..$#_ ) {
        push @all_xors, map $_[$i] ^ $_[$_], $i..$#_;
    };
    return max( @all_xors );
}
```

I haven't measured the run time for this, but I guess that the `map` call is quite a bit more efficient than writing out the `for` loop explicitly.
But how can we also get rid of the outer `for` loop?

The problem is that it is not easy to do nested `map` calls in perl.
There is only one `$_` variable, and it is the one of the inner `map`. 
That is why we still need the `$i` as a loop variable, to use it within the `map` code block. 

But sometimes we are lucky, in that we can 'encapsulate' the map call and get rid of the need for the inner `$_`.
Here, we can turn it into a one-line function:

```perl
sub xor_slice { return map $_[0] ^ $_, @_[1..$#_] }
sub max_xor3 {
    return max( map xor_slice( @_[$_..$#_] ), 0 .. ( $#_ - 1 ) );
}
```

No for loop anymore!
More efficient, I guess, and less boring! ;-) 


**Thank you for the challenge!**
