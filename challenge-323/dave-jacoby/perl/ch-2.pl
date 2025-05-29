#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };
use List::Util   qw{ uniq };

my @examples = (

    { income => 10, tax => [ [ 3, 50 ], [ 7, 10 ], [ 12, 25 ] ] },
    { income => 2,  tax => [ [ 1, 0 ],  [ 4, 25 ], [ 5,  50 ] ] },
    { income => 0,  tax => [ [ 2, 50 ] ] },
);

for my $example (@examples) {
    my $income = $example->{income};
    my @tax    = $example->{tax}->@*;
    my $tax    = join ', ', map { qq{[ $_ ]} }
        map { join ', ', $_->@* } @tax;
    my $output = tax_amount($example);
    say <<"END";
    Input:  \@income = $income,
            \@tax = ($tax)
    Output: $output
END
}

sub tax_amount($example) {
    my $total  = 0;
    my $income = $example->{income};
    my @tax    = $example->{tax}->@*;
    for my $i ( 0 .. $#tax ) {
        my $bracket = $tax[$i];
        my ( $upto, $rate ) = $bracket->@*;
        my $prev = 0;
        $prev = $i - 1 >= 0 ? $tax[ $i - 1 ][0] : 0;
        my $subset = 0;
        if    ( $income >= $upto ) { $subset = $upto - $prev; }
        elsif ( $income >= $prev ) { $subset = $income - $prev; }
        my $subtax = $subset * ( $rate / 100 );
        $total += $subtax;
    }
    return sprintf '%.02f', $total;
}
