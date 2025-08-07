#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ [ 2,       1 ],       [ 2,       3 ],       [ 2,       5 ] ],
    [ [ 1,       4 ],       [ 3,       4 ],       [ 10,      4 ] ],
    [ [ 0,       0 ],       [ 1,       1 ],       [ 2,       3 ] ],
    [ [ 1,       1 ],       [ 1,       1 ],       [ 1,       1 ] ],
    [ [ 1000000, 1000000 ], [ 2000000, 2000000 ], [ 3000000, 3000000 ] ],
);

for my $input (@examples) {
    my $output = straight_line( $input->@* );
    my $str = join ',', map { qq{[$_]} } map { join ', ', $_->@* } $input->@*;
    say <<"END";
    Input:  \@str = ($str)
    Output:        $output
END
}

sub straight_line (@array) {
    my %angles;
    for my $i ( 0 .. $#array ) {
        my $k = $array[$i];
        for my $j ( $i + 1, $#array ) {
            next unless $i != $j;
            next unless defined $array[$j];
            my $l  = $array[$j];
            my $a1 = find_angle( $k, $l );
            my $a2 = find_angle( $l, $k );
            $angles{$a1} = 1;
            $angles{$a2} = 1;
        }
    }
    return scalar keys %angles <= 2 ? 'true' : 'false';
}

sub find_angle ( $p1, $p2 ) {
    return 
    # sprintf '%.06f', 
        atan2( $p1->[1] - $p2->[1], $p1->[0] - $p2->[0] );
}
