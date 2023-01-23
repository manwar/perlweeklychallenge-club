#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 uniq };

my @examples = ( 1, 3, 5, 7 );

for my $e (@examples) {
    my @piles = penny_piles($e);
    @piles = sort { length $b <=> length $a }
        uniq sort map { join ',', $_->@* } @piles;
    my $count = scalar @piles;
    my $list  = join "\n\t", '', @piles;
    say <<"END";
    Input:  \$n = $e
    Output: $count
    $list
END
}

sub penny_piles ( $n, @array ) {
    my $sum  = sum0 @array;
    my @copy = sort { $a <=> $b } @array;
    if ( $sum > $n ) { return }
    if ( $sum == $n ) {
        return \@copy;
    }

    my @output;
    for my $i ( reverse 1 .. $n ) {
        my @local = sort { $a <=> $b } $n, @array;
        push @output, penny_piles( $n, @array, $i );
    }
    return @output;
}

