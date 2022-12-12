#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min max };

my @examples = ( [ 1, 1, 2, 6, 2 ], [ 1, 3, 5, 7 ], [ 6, 4, 4, 6, 1 ] );

for my $e (@examples) {
    my $list = join ',', $e->@*;
    my $o    = most_frequent_even( $e->@* );
    say <<"END";
    Input:  \@list = $list
    Output: $o
END
}

sub most_frequent_even( @list ) {
    my %hash;
    map { $hash{$_}++ } grep { 0 == $_ % 2 } @list;
    if ( scalar keys %hash ) {
        my $max = max values %hash;
        return min grep { $hash{$_} == $max } keys %hash;
    }
    return -1;
}

