#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{ uniq };

my $x = 3;
my $y = $x;

GetOptions(
    'x=i' => \$x,
    'y=i' => \$y,
);

croak 'X not positive' unless $x > 0;
croak 'Y not positive' unless $x > 0;
croak 'X not integer'  unless $x == int $x;
croak 'Y not integer'  unless $y == int $y;

make_table( $x, $y );

sub make_table ( $x, $y ) {
    my @headers = make_line( 'x', '|', 1 .. $y );
    my $headers = join ' ', @headers;
    my $line    = $headers;
    $line =~ s/\|/+/gmix;
    $line =~ s/[\w\s]/-/gmix;

    say qq{\$x = $x , \$y = $y };
    say '';
    say $headers;
    say $line;
    my $matrix = make_matrix( $x, $y );
    my @dt = uniq sort {$a<=>$b} flatten_matrix($matrix);
    my $dt = join ', ', @dt;
    my $count = scalar @dt;

    my $c = 0;
    for my $i ( $matrix->@* ) {
        $c++;
        my $line = make_line( $c, '|', $i->@* );
        say $line;
    }
    say '';
    say qq{Distinct Terms: $dt};
    say qq{Count: $count};
}

sub make_line ( @array ) {
    my @headers = ( map { sprintf '%3s', $_ } @array );
    return join ' ', @headers;
}

sub make_matrix ( $x, $y ) {
    my $matrix;
    for my $i ( 0 .. $x - 1 ) {
        my $ii = $i + 1;
        for my $j ( 0 .. $y - 1 ) {
            my $jj = $j + 1;
            my $tt = $ii * $jj;
            $matrix->[$i][$j] = $tt;
        }
    }
    return $matrix;
}

sub flatten_matrix ( $matrix ) {
    return map { $_->@* } $matrix->@*;
}