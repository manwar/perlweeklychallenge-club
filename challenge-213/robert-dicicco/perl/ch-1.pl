#!/usr/bin/env perl
=begin pod
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-17
Challenge 213 Fun Sort ( Perl )
-----------------------------------
=cut
use strict;
use warnings;
use feature 'say';

my @lists = ([1,2,3,4,5,6],[1,2],[1]);

for my $arr (@lists) {
    say "Input: \@list = (@{$arr})";
    my @odds =  grep { $_ % 2 } @{$arr};
    my @evens = grep { $_ % 2 == 0 } @{$arr};
    my @combo = (@evens, @odds);
    say "(".join( ',', @combo ).")";
    say " ";
}

=begin pod
-----------------------------------
SAMPLE OUTPUT
perl .\FunSort.pl
Input: @list = (1 2 3 4 5 6)
(2,4,6,1,3,5)

Input: @list = (1 2)
(2,1)

Input: @list = (1)
(1)
-----------------------------------
=cut


