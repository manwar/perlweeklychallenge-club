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

fib_sum($n);

#
sub fib_sum ( $n ) {
    my @fib = reverse fib_list($n);
    my @list = ( [] );
    my @sums;
    my %no;

    while (@list) {
        my $entry = shift @list;
        for my $fib (@fib) {
            next if grep { $_ == $fib } $entry->@*;
            my $new->@* = sort { $b <=> $a } $fib, $entry->@*;
            my $sum = sum0 $new->@*;
            my $join = join ',', $new->@*;
            next if $no{$join}++;
            push @list, $new if $sum < $n;
            push @sums, $new if $sum == $n;
        }
    }

    if ( scalar @sums ) {
        for my $sum (@sums) {
            my $s = scalar $sum->@*;
            my $p = join ' + ', $sum->@*;
            say qq{$s as ($n = $p)};
        }
    }
    else { print 0 }
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
