#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Compare;
use JSON;
my $json = JSON->new->pretty;

my @examples = (

    [ 2,  3, -1 ],
    [ 3,  2, -4 ],
    [ 1,  -1, ],
    [ -1, 1, ],
    [ 3,  1, -2, -4 ],
    [ 3,  1, -4, -2 ],
    [ 4,  1, -2, -4 ],

);

for my $e (@examples) {
    my $i = join ', ', $e->@*;
    my @o = number_collision( $e->@* );
    my $o = join ', ', @o;
    say <<"END";
    Input:  \@list = ($i)
    Output: ($o)
END
    say '';
}

sub number_collision ( @array ) {
    while ( _judge_array(@array) ) {
        @array = grep { defined } @array;
        for my $i ( 0 .. -2 + scalar @array ) {
            my $j = $i + 1;
            next if !defined $array[$i];
            next if !defined $array[$j];
            my $ai = $array[$i];
            my $aj = $array[$j];
            if ( $ai > 0 && $aj < 0 ) {
                if ( abs $ai == abs $aj ) {
                    delete $array[$i];
                    delete $array[$j];
                }
                elsif ( abs $ai < abs $aj ) {
                    $array[$i] = $array[$j];
                    delete $array[$j];
                }
                elsif ( abs $ai > abs $j ) { delete $array[$j]; }
            }
        }
    }
    @array = grep { defined } @array;
    return @array;
}

sub _judge_array ( @array ) {
    @array = grep { defined } @array;
    for my $i ( 0 .. -2 + scalar @array ) {
        my $j = $i + 1;
        return 1 if $array[$i] > 0 && $array[$j] < 0;
    }
    return 0;
}
