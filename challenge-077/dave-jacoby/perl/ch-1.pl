#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{ max sum0 uniq };

my $n = 9;
GetOptions( 'n=i' => \$n );
croak "n < 1" if $n < 1;

my $x = fib_sum($n);
my $s = scalar $x->@*;
my $p = join ' + ', $x->@*;
say qq{$s as ($n = $p)};

# 
sub fib_sum ( $n ) {
    my @fib = reverse fib_list($n);
    my @list = ( [] );
    my %no;

    while (@list) {
        my $entry = shift @list;
        my $join = join ',', $entry->@*;
        next if $no{$join}++;

        for my $fib (@fib) {
            next if grep { $_ == $fib } $entry->@*;
            my $new->@* = sort { $a <=> $b } $fib, $entry->@*;
            my $sum = sum0 $new->@*;
            push @list, $new if $sum < $n;
            return $new if $sum == $n;
        }
    }
    print 0 && exit;
}

# creates a list of fibonacci values where each value is
# less than n and greater than zero, because zero is useless
# in summation
sub fib_list( $n ) {
    my @output = ( 0, 1 );
    my $i = 2;

    while ( max(@output) < $n ) {
        $output[$i] = $output[ $i - 1 ] + $output[ $i - 2 ];
        my $max = max(@output);
        $i++;
    }

    @output = uniq grep { $_ } grep { $_ <= $n } @output;
    return @output;
}
