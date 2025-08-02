#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };
use Algorithm::Permute;

my @examples = (

    [ 1, 3 ],
    [ 5, 1, 6 ],
    [ 3, 4, 5, 6, 7, 8 ],
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my $output = total_xor( $example->@* );
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub total_xor(@example) {
    my $sum     = 0;
    my @indices = 0 .. $#example;
    for my $l ( 1 .. scalar @example ) {
        my %done;
        my $p = Algorithm::Permute->new( \@indices, $l );
        while ( my @x = sort $p->next ) {
            my $x = join ' ', sort @x;
            next if $done{$x}++;
            my @y = map { $example[$_] } @x;
            my $s = find_xor(@y);
            $sum += $s;
        }
    }
    return $sum;
}

sub find_xor (@array) {
    my $x = 0;
    while (@array) { my $i = shift @array; $x = $x ^ $i; }
    return $x;
}
