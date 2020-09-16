#!/usr/bin/env raku

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/#TASK1
#
# It appears to to me, by example 2, the right-most element is always a leader.
#

sub leaders(@A) {
    my $max = -Inf;
    return @A.reverse.grep(-> $v { ($v > $max) ?? ( $max = $v ; True ) !! False }).reverse();
}

say leaders(@*ARGS);
