#!/usr/bin/env perl
use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{ max };
use List::Compare;

my $n = 3;
GetOptions( 'number=i' => \$n );
croak 'Negative Number' if $n < 1;
my $o = gcd($n);
say <<"END";
    INPUT:  $n
    OUTPUT: $o
END

sub gcd( $n ) {
    my $output = 0;
    for my $i ( 1 .. $n - 1 ) {
        for my $j ( $i + 1 .. $n ) {
            my $di->@* = get_divisors($i);
            my $dj->@* = get_divisors($j);
            my $dc     = List::Compare->new( $di, $dj );
            my @d      = $dc->get_intersection;
            my $g      = max @d;
            $output += $g;
        }
    }
    return $output;
}

sub get_divisors ( $n ) {
    my @div;
    for my $i ( 1 .. $n ) { push @div, $i if $n % $i == 0; }
    return @div;
}
