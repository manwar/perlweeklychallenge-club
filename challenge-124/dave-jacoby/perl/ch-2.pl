#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

use Algorithm::Permute;
use List::Util qw{sum};

my @sets;
push @sets, [ 10, -15, 20, 30, -25, 0, 5, 40, -5 ];
push @sets, [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ];

for my $set (@sets) {
    my ( $s1, $s2 ) = tug_of_war( $set->@* );
    my $sum1 = sum $s1->@*;
    my $sum2 = sum $s2->@*;
    say join ' ', 'Set =  ', $set->@*;
    say join ' ', 'Sub1 = ', $s1->@*;
    say "Sum1 = $sum1";
    say join ' ', 'Sub2 = ', $s2->@*;
    say "Sum2 = $sum2";
    say 'DIFF = ' . abs( $sum1 - $sum2 );
    say '';
}

sub tug_of_war (@set) {
    my $set->@* = @set;
    my %done;
    my $mdiff  = 2 * sum $set->@*;
    my $max    = scalar $set->@*;
    my $center = int( $max / 2 );
    my ( $set1, $set2 );
    my $p = Algorithm::Permute->new($set);

    while ( my @res = $p->next ) {
        my @sub1;
        my @sub2;
        for my $i ( 0 .. -1 + $max ) {
            my $n = $res[$i];
            if ( $i < $center ) {
                push @sub1, $n;
            }
            else {
                push @sub2, $n;
            }
        }
        my $comp = join ' ', ( sort { $a <=> $b } @sub1 ), '|',
            ( sort { $a <=> $b } @sub2 );
        next if $done{$comp}++;
        my $sub1 = sum @sub1;
        my $sub2 = sum @sub2;
        my $diff = abs( $sub1 - $sub2 );
        if ( $diff < $mdiff ) {
            $mdiff    = $diff;
            $set1->@* = sort { $a <=> $b } @sub1;
            $set2->@* = sort { $a <=> $b } @sub2;
        }
        else { next }
    }
    return ( $set1, $set2 );
}
