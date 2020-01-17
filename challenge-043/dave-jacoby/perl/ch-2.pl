#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Instead of finding all the self-descriptive numbers in a given set,
# we generate them, knowing that, for 7 or more, there will be
#   * 2 uses of the number 1 
#       + 2
#       + n - 4
#   * 1 use of the number 2, being the count of 1s
#   * n - 4 uses of 0
#       + -1 because n in base-n will always be represented as 10
#       + -1 from 0
#       + -1 from 1
#       + -1 from 2

# I would combine this and ch-2a, but nah.

my @base      = ( 0 .. 9, 'a' ... 'z' );
my %to_base   = map { state $c = 0; $_ => $c++ } @base;
my %from_base = reverse %to_base;

for my $n ( reverse 7 .. 37 ) {
    my $s = get_self($n);
    next unless check_self( $s, $n );
    say join "\t", $n, $s;
}

sub check_self ( $s, $n ) {
    no warnings;
    my @s = split //, $s;
    my $b = $s[0];
    my @check;

    for my $i ( 0 .. $n - 1 ) {
        my $eye = $from_base{$i};

        my $c = $s[$i];

        my @all = grep { $_ eq $eye } @s;
        my $all = join ',', @all;

        my $j   = scalar @all;
        my $jay = $from_base{$j};

        return 0 if $c ne $jay;
    }

    return 1;
}

sub get_self( $n ) {
    my @output = map { 0 } 1 .. $n;
    my $b      = $n - 4;
    $output[0]  = $from_base{$b};
    $output[1]  = 2;
    $output[2]  = 1;
    $output[$b] = 1;
    return join '', @output;
}
