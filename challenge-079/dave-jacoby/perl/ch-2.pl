#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Getopt::Long;
use List::Util qw{ max sum0 };

my @n = grep { $_ >= 1 } @ARGV;
@n = ( 2, 1, 4, 1, 2, 5 ) unless scalar @n;

# make_histogram(@n);
my $trapped = trap_rain_water(@n);

my $units = $trapped == 1 ? 'unit' : 'units';
say qq{$trapped $units trapped};

sub make_histogram ( @n ) {
    my $max = max @n;
    say '';
    for my $i ( reverse 1 .. $max ) {
        my @h = map { $i <= $_ ? '#' : ' ' } @n;
        say join ' ', $i, @h;
    }
    say join '-', ' ', map { '-' } @n;
    say join ' ', ' ', @n;
    say '';
}

sub trap_rain_water ( @n ) {
    my $max = max @n;
    my $s   = scalar @n;
    my $c   = 0;

    my @hist;

    for my $i ( reverse 1 .. $max ) {
        my $z = sum0 map { $i <= $_ ? 1 : 0 } @n;
        my @h;
        my $hh = [];
        push $hh->@*, $i, '';

        for my $j ( 0 .. $s - 1 ) {
            my $e = $n[$j];              # equals
            my $p = $e >= $i ? 1 : 0;    # is peak

            my @lt = @n[ 0 .. $j - 1 ];
            my @gt = @n[ $j + 1 .. $s - 1 ];
            my $lt = scalar grep { $_ >= $i } @lt;          # is peak to left
            my $gt = scalar grep { $_ >= $i } @gt;          # is peak to right
            my $t  = $p != 1 && $lt > 0 && $gt > 0 ? 1 : 0; # has trapped
            $c += $t;

            push @h, $e >= $i ? '#' : $t;
            my $v = ' ';
            $v = '#' if $p;
            $v = '.' if $t;
            push $hh->@*, $v;
        }

        push @hist, $hh;
    }

    say join "\n", map { join ' ', $_->@* } @hist, [], [ ' ', '', @n ];
    say '';

    return $c;
}
