#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ sum0 };

my @examples = (

    [ 2, 5, 3, 6, 4 ],
    [ 1, 3 ],
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my $output = odd_sum( $example->@* );
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub odd_sum(@ints) {
    my $output;
    for my $l ( map { $_ * 2 - 1 } 1 .. $#ints ) {
        next if $l > scalar @ints;
        for my $i ( 0 .. $#ints ) {
            my $end = -1 + $i + $l;
            next unless defined $ints[$end];
            my @slice = @ints[ $i .. $end ];
            $output += sum0(@slice);
        }
    }
    return $output;
}
