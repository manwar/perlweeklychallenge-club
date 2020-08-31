#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum };
use JSON;
my $json = JSON->new->pretty->canonical;

my @C      = ( 1, 2, 4 );
my $S      = 6;
my @output = resort( coins_sum( [], $S, \@C ) );

make_output( $S, @output );

sub coins_sum ( $input, $sum, $coins ) {
    my @output;
    for my $c ( $coins->@* ) {
        my $input2->@* = $input->@*;
        push $input2->@*, $c;
        $input2->@* = sort $input2->@*;
        my $input3 = join ',', sort $input2->@*;
        my $sum2 = $sum - $c;
        if ( $sum2 > 0 ) {
            push @output, coins_sum( $input2, $sum2, $coins );
        }
        elsif ( $sum2 == 0 ) {
            push @output, $input2;
        }
    }
    return wantarray ? @output : \@output;
}

sub resort ( @array ) {
    my $done = {};
    return grep { !$done->{$_}++ }
        map { join ',', sort $_->@* } @array;
}

sub make_output ( $sum, @output ) {
    my $c = scalar @output;
    my @letters = 'a'..'z';

    say qq{ There are 6 possible ways to make sum $sum };
    for my $i ( 0 .. $#output ) {
        my $l = $letters[$i];
        say qq{  $letters[$i]) $output[$i] };
    }

}
