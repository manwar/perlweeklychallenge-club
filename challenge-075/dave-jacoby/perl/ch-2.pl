#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ max };
use JSON;
my $json = JSON->new->pretty->canonical;

{
    my @A = ( 2, 1, 4, 5, 3, 7 );
    my @histogram = make_histogram(@A);
    find_largest_rectangle(@histogram);
}
{
    my @A = ( 3, 2, 3, 5, 7, 5 );
    my @histogram = make_histogram(@A);
    find_largest_rectangle(@histogram);
}

exit;

sub make_histogram ( @input ) {
    my $max = max @input;
    my @output;

    for my $i ( 0 .. scalar @input ) {
        my $local = [];
        my $n     = $input[$i];
        next unless $n;
        for my $j ( 1 .. $max ) {
            push $local->@*, $j <= $n ? '#' : ' ';
        }
        push @output, $local;
    }

    return @output;
}

sub display_histogram( @histogram ) {
    my $max_x = scalar @histogram - 1;
    my $max_y = scalar $histogram[0]->@* - 1;
    for my $y ( reverse 0 .. $max_y ) {
        for my $x ( 0 .. $max_x ) {
            my $c = $histogram[$x][$y];
            print $c . ' ';
        }
        say '';
    }
    say '';
}

sub find_largest_rectangle( @histogram ) {
    my $max_x = scalar @histogram - 1;
    my $max_y = scalar $histogram[0]->@* - 1;

    my @output;

    for my $x1 ( 0 .. $max_x - 1 ) {
        for my $x2 ( $x1 + 1 .. $max_x ) {
            for my $y1 ( 0 .. $max_y ) {
                for my $y2 ( $y1 .. $max_y ) {

                    my ( $c1, $c2 ) = ( 0, 0 );
                    my @v;
                    for my $x ( $x1 .. $x2 ) {
                        for my $y ( $y1 .. $y2 ) {
                            my $v = $histogram[$x][$y];
                            push @v, $v;
                            $c1++;
                            $c2++ if $v eq '#';
                        }
                    }

                    next if $c1 != $c2;
                    push @output, [ $c1, $x1, $y1, $x2, $y2 ];
                }
            }
        }
    }

    @output = sort { $b->[0] <=> $a->[0] } @output;
    my ( $c1, $x1, $y1, $x2, $y2 ) = $output[0]->@*;
    my $columns = join ',', map { $_ + 1 } $x1 .. $x2;
    my $x       = 1 + $x2 - $x1;
    my $y       = 1 + $y2 - $y1;


    display_histogram(@histogram);
    say qq{the largest rectangle ($x x $y) is formed by columns ($columns)};
    say '';
}
