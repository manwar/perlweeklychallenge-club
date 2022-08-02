#!/usr/bin/env perl
# Perl weekly challenge 176
# Task 2: Reversible numbers
#
# See https://wlmb.github.io/2022/08/01/PW176/#task-2-reversible-numbers
use v5.36;
use List::Util qw(all);
my @reversible;
for (10..100-1){
     push @reversible, $_ if is_reversible($_)
}
say join ", ", @reversible;
sub is_reversible($n){   # read the comments from the bottom up
    return all {$_%2==1} # and check they are all odd
        split "",        # split the digits of the result
            $n           # the original number
            +            # add it to
            join "",     # join them to make the reversed number (base 10)
            reverse      # reverse them
            split "", $n # separate the digits
}
