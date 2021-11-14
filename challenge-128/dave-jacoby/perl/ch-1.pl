#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

use utf8;
use JSON;
use List::Util qw{ sum0 };

my $json = JSON->new;

my @experiments;
push @experiments, <<'END';
    1 0 0 0 1 0 
    1 1 0 0 0 1 
    1 0 0 0 0 0 
END
push @experiments, <<'END';
    0 0 1 1 
    0 0 0 1 
    0 0 1 0 
END
push @experiments, <<'END';
    
    1 1 0 0 1 0 1 0
    0 0 0 0 1 0 1 0
    0 0 0 0 0 1 1 0
    1 1 1 1 0 0 0 1
    1 1 0 1 0 0 0 1

END

for my $e (@experiments) {
    my @m =
        map {
        my @r = grep { /\d/ } split /\s+/, $_;
        \@r
        }
        grep { /\d/ }
        split m{\n}, $e;
    my @subs =
        sort { matrix_size($b) <=> matrix_size($a) } find_submatrices( \@m );
    my $sub  = shift @subs;
    my $size = matrix_size($sub);
    say 'INPUT:';
    display_matrix( \@m );
    say 'OUTPUT:';
    display_matrix($sub);
    say '';
}

sub find_submatrices ( $matrix ) {
    my @subs;
    my $maxx = -1 + scalar $matrix->@*;
    my $maxy = -1 + scalar $matrix->[0]->@*;
    for my $x ( 0 .. $maxx ) {
        for my $y ( 0 .. $maxy ) {
            if ( $matrix->[$x][$y] == 0 ) {
                for my $i ( $x + 1 .. $maxx ) {
                    for my $j ( $y + 1 .. $maxy ) {
                        my $sub = make_submatrix( $matrix, $x, $y, $i, $j );
                        my $n   = sum0 flatten_matrix($sub);
                        next if $n;
                        push @subs, $sub;
                    }
                }
            }
        }
    }
    return @subs;
}

sub make_submatrix ( $matrix, $startx, $starty, $endx, $endy ) {
    my $sub = [];
    for my $i ( $startx .. $endx ) {
        my $x = $i - $startx;
        for my $j ( $starty .. $endy ) {
            my $y = $j - $starty;
            my $v = $matrix->[$i][$j];
            $sub->[$x][$y] = $v;
        }
    }
    return $sub;
}

sub matrix_size ( $matrix ) {
    return scalar flatten_matrix($matrix);
}

sub display_matrix ($matrix ) {
    say join "\n", map { join ' ', "\t", '[', $_->@*, ']' } $matrix->@*;
}

sub flatten_matrix ($matrix) {
    return map { $_->@* } $matrix->@*;
}
