#!/usr/bin/perl

#
# Perl Weekly Challenge - 073
#
# Task #1: Min Sliding Window
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073
#

package MinSlidingWindow;

use Moo;
use List::Util qw(min);

sub generate {
    my ($self, $list, $size) = @_;

    die "ERROR: Missing list.\n"
        unless defined $list;
    die "ERROR: Invalid list [$list].\n"
        unless ($list =~ /^[\-?\d\,?\s?]+$/);

    $list =~ s/\s//g;
    $list = [ split /\,/, $list ];

    die "ERROR: Missing size.\n"
        unless defined $size;
    die "ERROR: Invalid size [$size].\n"
        unless (($size >= 2) && ($size - 1 <= $#$list));

    my $index = 0;
    my @min_sliding_window = ();
    while ($index + $size - 1 <= $#$list) {
        push @min_sliding_window,
        min ( map { $list->[$_] } $index .. $index + $size - 1 );
        $index++;
    }

    return \@min_sliding_window;
}

package main;

use Test2::V0 -target => 'MinSlidingWindow';

my $list = "1, 5, 0, 2, 9, 3, 7, 6, 4, 8";
my %test_cases = (
    2 => "1, 0, 0, 2, 3, 3, 6, 4, 4",
    3 => "0, 0, 0, 2, 3, 3, 4, 4",
    4 => "0, 0, 0, 2, 3, 3, 4",
    5 => "0, 0, 0, 2, 3, 3",
    6 => "0, 0, 0, 2, 3",
    7 => "0, 0, 0, 2",
    8 => "0, 0, 0",
    9 => "0, 0",
   10 => "0",
);

warn "List = $list\n";
foreach my $size (sort { $a <=> $b } keys %test_cases) {
    my $min = join ", ", @{$CLASS->generate($list, $size)};
    is $min, $test_cases{$size}, "testing window size $size";
}

done_testing;
