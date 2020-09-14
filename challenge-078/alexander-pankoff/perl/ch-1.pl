#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(all reduce);

# You are given an array @A containing distinct integers.
#
# Write a script to find all leader elements in the array @A. Print (0) if none
# found.
#
# >> An element is leader if it is greater than all the elements to its right
# >> side.

my @A = @ARGV;

my @leaders = find_leader_elements(@A);
@leaders = (0) unless @leaders;

say '(' . join( ', ', @leaders ) . ')';

exit;

sub find_leader_elements(@list) {
    my $leaders = reduce {
        my @leaders = @$a;
        my $current = $b;

        ( all { $current > $_ } @leaders ) ? [ $current, @leaders ] : $a
    }
    [], reverse @list;

    return @{$leaders};
}
