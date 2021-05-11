#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @values = ( 3, 4, 5 );
@values = @ARGV if @ARGV;

for my $v (@values) {
    my $c = 1;
    say '-' x 20;
    my @steps = climb_stairs($v);
    say qq{INPUT:  $v};
    say qq{OUTPUT: } . scalar @steps;
    for my $opt (@steps) {
        say qq{\tOption $c: $opt};
        $c++;
    }
}

sub climb_stairs ( $v, $max_steps = 2 ) {
    my @output;
    for my $n ( 1 .. $max_steps ) {
        my $step = $n < 2 ? '1 step' : "$n steps";
        my $w    = $v - $n;
        if ( $w > 0 ) {
            push @output,
                map { $step . ' + ' . $_ } climb_stairs( $w, $max_steps );
        }
        elsif ( $w == 0 ) { push @output, $step; }
    }
    return @output;
}
