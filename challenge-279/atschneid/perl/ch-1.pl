use strict;
use warnings;

use v5.38;

my @inputs = (
    [
     ['R', 'E', 'P', 'L'],
     [3, 2, 1, 4]
    ],
    [
     ['A', 'U', 'R', 'K'],
     [2, 4, 1, 3]
    ],
    [
     ['O', 'H', 'Y', 'N', 'P', 'T'],
     [5, 4, 2, 6, 1, 3]
    ],
    [
     ['O', 'H', 'Y', 'N', 'P', 'A', 'T'],
     [5, 4, 2, 6, 1, 3, 3]
    ]
    );

for (@inputs) {
    my @letters = @{$_->[0]};
    my @weights = @{$_->[1]};
    say join ( ", ", @letters ) . " :: " .
	join ( ", ", @weights ) . " => " .
	sort_letters( \@letters, \@weights );
}

sub sort_letters( $letters, $weights ) {
    my @letters = @$letters;
    my @weights = @$weights;

    die "inputs must be the same length" unless $#weights == $#letters;

    my @zipped = map {[$weights[$_], $letters[$_]]} (0 .. $#weights);
    return join '', map { $_->[1] } sort {$a->[0] <=> $b->[0]} @zipped;
}
