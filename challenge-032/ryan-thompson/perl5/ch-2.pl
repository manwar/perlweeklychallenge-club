#!/usr/bin/env perl

# ASCII Bar Chart
#
# I've added the optional "sort by" option, and then I went and added
# negative numbers and auto-scaling to a user-specified --width for fun.
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use strict;
use warnings;
use List::Util qw/min max/;
use Math::Round;

my %data = ( foo => 10, bar => 20, foobar => 50 );

print_bar_graph_simple(\%data);
say '';
print_bar_graph({ %data, neg => -25 }, { char => '=', width => 50 });

# Simple version. Auto-sizes the labels, that's about it.
sub print_bar_graph_simple {
    my ($data) = @_;

    my $len    = max map { length } keys %$data;
    printf "%-${len}s | %s\n", $_, '#' x round($data->{$_})
        for sort keys %$data;
}

# "Deluxe" version with scaling, custom bars, and negative number support
# by_key: True = Sort by key, then value          [Default: value, then key ]
#  width: Scale to total width, including labels  [Default: undef (no scale)]
#   char: Character to use for bars in bar chart  [Default: #               ]
sub print_bar_graph {
    my ($data, $opts) = @_;

    my $sort = $opts->{by_key}
        ? sub {          $a cmp $b          || $data->{$a} <=> $data->{$b} }
        : sub { $data->{$a} <=> $data->{$b} ||          $a cmp $b          };

    # Housekeeping for number scaling and label sizing
    my $len    = max map { length } keys %$data;
    my $width  = $opts->{width} ? $opts->{width} - $len - 1 : 0;
    my $max    = max $width, values %$data;
    my $negmax = min   0,    values %$data;
    my $scale  = $width ? $width / (abs($negmax) + 1 + $max) : 1;
    my $negpad = round($scale * abs($negmax));

    printf "%-${len}s %${negpad}s|%s\n", $_,
        $data->{$_} < 0
            ? (    $opts->{char} x round(abs($data->{$_}) * $scale), '')
            : ('', $opts->{char} x round(    $data->{$_}  * $scale))
                for sort $sort keys %$data;
}
