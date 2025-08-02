# Challenge 256 tasks: Easy Pairs - Easy Merge
**Challenge 256 solutions in Perl by Matthias Muth**

## Task 1: Maximum Pairs

> You are given an array of distinct words, `@words`.<br/>
> Write a script to find the maximum pairs in the given array. The words `$words[i]` and `$words[j]` can be a pair one is reverse of the other.<br/>
> <br/>
> Example 1<br/>
> Input: @words = ("ab", "de", "ed", "bc")<br/>
> Output: 1<br/>
> There is one pair in the given array: "de" and "ed"<br/>
> <br/>
> Example 2<br/>
> Input: @words = ("aa", "ba", "cd", "ed")<br/>
> Output: 0<br/>
> <br/>
> Example 3<br/>
> Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))<br/>
> Output: 2<br/>

Ah, an easy one.<br/>
For each word we check whether we have seen its reverse before, and increment
our counter if so. Then we remember that we have seen the current word.

Perl supports us with the `reverse` function to reverse the characters of a string (also to reverse a list, but this is not what we use here).

```perl
#!/usr/bin/env perl
use v5.36;

sub maximum_pairs( @words ) {
    my $n = 0;
    my %known;
    for ( @words ) {
        ++$n if $known{ reverse $_ };
        $known{$_} = 1;
    }
    return $n;
}

use Test2::V0 qw( -no_srand );
is maximum_pairs( "ab", "de", "ed", "bc" ), 1,
    'Example 1: maximum_pairs( ("ab", "de", "ed", "bc") ) == 1';
is maximum_pairs( "aa", "ba", "cd", "ed" ), 0,
    'Example 2: maximum_pairs( ("aa", "ba", "cd", "ed") ) == 0';
is maximum_pairs( "uv", "qp", "st", "vu", "mn", "pq" ), 2,
    'Example 3: maximum_pairs( ("uv", "qp", "st", "vu", "mn", "pq") ) == 2';
done_testing;
```

If you don't have perl 5.36 (which I highly recommend!), you can use this
instead: 

```perl
use v5.20;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
```
Perl 5.20 has been around since 2014, so I guess that chances are high
that your perl is more recent than that.<br/>
If not, and you are not able to update your system's perl for any reason,
I suggest installing [`perlbrew`](https://perlbrew.pl),
which is an admin-free perl installation management tool.

## Task 2: Merge Strings

> You are given two strings, `$str1` and `$str2`.<br/>
> Write a script to merge the given strings by adding in alternative order starting with the first string. If a string is longer than the other then append the remaining at the end.<br/>
> <br/>
> Example 1<br/>
> Input: \$str1 = "abcd", \$str2 = "1234"<br/>
> Output: "a1b2c3d4"<br/>
> <br/>
> Example 2<br/>
> Input: \$str1 = "abc", \$str2 = "12345"<br/>
> Output: "a1b2c345"<br/>
> <br/>
> Example 3<br/>
> Input: \$str1 = "abcde", \$str2 = "123"<br/>
> Output: "a1b2c3de"<br/>

The idea for this challenge is to turn the two string into lists of characters,
and then merge the two lists.<br/>
There are a lot of functions for list manipulations in the `List::Util` core
module, one of which is `mesh`. It does exactly what we need.
The only downside is that if the lists are of different lengths, there will be
`undef` values inserted in the result. But it is easy to `grep` those out
before assembling the result into a return string.
At least easier than splitting up the longer list into two parts, and after
`mesh`ing the first part with the shorter string appending the second part.

`mesh` has been part of `List::Util` since its version 1.56,
which means has been part of standard Perl since Perl 5.25 (released in 2014).

Its implementation is different from the `mesh` function in the
`List::MoreUtils` CPAN module, in that it uses array references as parameters, not array variables that are used *by reference* (using prototypes).<br/>
I prefer the `List::Util` version here,
because we can directly use anonymous arrays containing the split characters as parameters,
making it unnecessary to declare and use any array variables.

```perl
#!/usr/bin/env perl

use v5.36;

use List::Util qw( mesh );

sub merge_strings( $str1, $str2 ) {
    return join "",
        grep defined,
            mesh [ split //, $str1 ], [ split //, $str2 ];
}

use Test2::V0 qw( -no_srand );
is merge_strings( "abcd", 1234 ), "a1b2c3d4",
    'Example 1: merge_strings( ("abcd", 1234) ) == "a1b2c3d4"';
is merge_strings( "abc", 12345 ), "a1b2c345",
    'Example 2: merge_strings( ("abc", 12345) ) == "a1b2c345"';
is merge_strings( "abcde", 123 ), "a1b2c3de",
    'Example 3: merge_strings( ("abcde", 123) ) == "a1b2c3de"';
done_testing;
```

#### **Thank you for the challenge!**

