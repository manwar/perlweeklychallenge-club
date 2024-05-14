#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = (

    [ 2, 1, 3, 4, 5 ],
    [ 3, 2, 4 ],
    [ 5, 4, 3, 8 ],
);

for my $example (@examples) {
    my @output = distribute_elements( $example->@* );
    my $output = join ', ', @output;
    my $ints   = join ', ', $example->@*;

    say <<"END";
        Input:  \@ints = ($ints)
        Output: ($output)
END
}

sub distribute_elements (@ints) {
    my @arr1;
    my @arr2;
    push @arr1, shift @ints;
    push @arr2, shift @ints;

    while ( @ints ) {
        my $i = shift @ints;
        if ( $arr1[-1] > $arr2[-1]) {
            push @arr1, $i;
        } else {
            push @arr2, $i;
        }
    }
    return @arr1,@arr2;
}
