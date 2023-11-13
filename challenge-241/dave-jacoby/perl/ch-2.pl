#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ 11, 8,  27, 4 ],
    [ 38, 29, 5,  3 ],
    [ 12, 4,  18 ],
    [ 4,  29, 33, 31, 37, 37 ],
    [ 30, 10, 22, 21 ],
    [ 30, 36, 29, 1,  15, 19, 10 ],
    [ 3,  20, 7,  36, 26, 39, 1 ],

);
for my $e (@examples) {
    my @output = prime_order( $e->@* );
    my @input  = $e->@*;
    my $output = join ', ', @output;
    my $input  = join ', ', @input;
    say <<~"END";
    Input:  \@int = ($input)
    Output: ($output)
    END
}

sub prime_order (@int) {
    return sort { num_factors($a) <=> num_factors($b) }
        sort { $a <=> $b } @int;
}

sub num_factors ($aa) {
    state $factors;
    return $factors->{$aa} if defined $factors->{$aa};
    my $bb = $aa;
    my @d;

    my $x = 2;
    my $y = int $aa / 2 + 1;
    my @factors;

    for my $n ( $x .. $y ) {
        while ( 0 == $bb % $n ) {
            $bb = $bb / $n;
            push @factors, $n;
        }
    }

    $factors->{$aa} = scalar @factors;
    return $factors->{$aa};

}
