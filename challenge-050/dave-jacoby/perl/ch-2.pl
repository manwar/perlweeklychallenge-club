#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use List::Util qw{ uniq };

my @L = map { 1 + int rand 50 } 1 .. 3 + int rand 20;
@L = ( 2, 2, 6, 1, 3 );
say join ' ', @L;
my @n = nobles(@L);
say join ' ', scalar @n ? @n : 'none';
exit;

# Commentary:
#   * "random" is perhaps not a good choice for input, because
#     it becomes increasingly unlikely that a noble integer
#     exists for the set.
#
#   * I don't believe a second noble number can exist in a
#     set. Let's take @L as an example. Those numbers are in some
#     order, but we're talking about them as greater than, so
#     we sort them:
#
#           1, 2, 3, 6
#
#     As the integer grows, the number of remaining integers shrinks.
#
#           1 -> 3 integers greater than
#           2 -> 2 integers greater than (WINNER!)
#           3 -> 1 integer greater than
#           6 -> no integers greater than
#
#   * if we repeat an integer, like [2, 2, 6, 1, 3] or [6, 2, 6, 1, 3], 
#     I am counting each number once -- there are still two integers greater 
#     than 2; 3 and 6, not 3, 6 and 6 -- but returning all the copies of the 
#     integer that count as noble numbers -- 2, 2 in the first example.

sub nobles ( @list ) {
    my @copy = @list;
    @list = uniq sort { $a <=> $b } @list;
    my @output;
    while (@list) {
        my $i = shift @list;
        my @i = grep { $_ == $i } @copy;
        push @output, @i if $i == scalar @list;
    }
    return @output;
}

__DATA__

TASK #2
Contributed by Ryan Thompson.
Noble Integer
You are given a list, @L, of three or more random integers between 1 and 50. A Noble Integer is an integer N in @L, such that there are exactly N integers greater than N in @L. Output any Noble Integer found in @L, or an empty list if none were found.

An interesting question is whether or not there can be multiple Noble Integers in a list.

For example,

Suppose we have list of 4 integers [2, 6, 1, 3].

Here we have 2 in the above list, known as Noble Integer, since there are exactly 2 integers in the list i.e.3 and 6, which are greater than 2.

Therefore the script would print 2.
