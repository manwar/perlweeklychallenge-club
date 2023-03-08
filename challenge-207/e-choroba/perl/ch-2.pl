#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub h_index(@citations) {
    @citations = sort { $b <=> $a } @citations;
    push @citations, -1;
    for my $i (0 .. $#citations) {
        return $i if $citations[$i] < $i + 1;
    }
}

use Test::More tests => 2 + 3;

is h_index(10, 8, 5, 4, 3), 4, 'Example 1';
is h_index(25, 8, 5, 3, 3), 3, 'Example 2';

is h_index(9, 7, 6, 2, 1), 3, 'Wikipedia';
is h_index(100), 1, 'Single publication';
is h_index(1, 1, 1, 1), 1, 'All ones';
