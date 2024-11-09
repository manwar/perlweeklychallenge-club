#https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
#length of longest consequtive sequence
#find all starts, which is elements x where x-1 dont exists
#for all starts, find how far that sequence goes, could be just 1 if x+1 dont exists

use strict; use warnings; use v5.10; use List::Util 'max';

sub llcs {
    my %input = map { $_ => 1 } @_;
    max(
        map { my $x = $_; 1 while $input{ ++$x }; $x - $_ }
        grep ! $input{ $_ - 1 }, @_
    )
    =~ s/^1$/-1/r
}


my @tests = (
    [ [10, 4, 20, 1, 3, 2]           => 4  ],
    [ [0, 6, 1, 8, 5, 2, 4, 3, 0, 7] => 9  ],
    [ [10, 30, 20]                   => -1 ],
    [ [10, 4, 20, 1, 3, 2, 31..33]   => 4  ],
    [ [10, 4, 20, 1, 3, 2, 31..35]   => 5  ],
);

say llcs( @{ $$_[0] } ) == $$_[1] ? 'ok' : 'error' for @tests;
