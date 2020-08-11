#!/usr/bin/env perl6

# ch-2.p6 - FizzBuzz "one-liner"
#
# Ryan Thompson <rjt@cpan.org>

use v6;

(1..20).map({
    !($_ % 15) ?? 'fizzbuzz'
 !! !($_ %  3) ?? 'fizz'
 !! !($_ %  5) ?? 'buzz'
 !!               $_
})».say;
