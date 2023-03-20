#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub minimum_index_sum($list1, $list2) {
    my %index;
    $index{ $list2->[$_] } //= $_ for 0 .. $#$list2;

    my $minimum = ($#$list2 + $#$list1 + 1);
    my @indices;
    for my $i (0 .. $#$list1) {
        if (exists $index{ $list1->[$i] }) {
            my $sum = $index{ $list1->[$i] } + $i;
            if ($sum <= $minimum) {
                @indices = () if $sum < $minimum;
                $minimum = $sum;
                push @indices, $i;
            }
        }
    }
    return [@$list1[@indices]]
}

use Test2::V0;
plan 3;

is minimum_index_sum([qw[ Perl Raku Love]], [qw[ Raku Perl Hate ]]),
    [qw[ Perl Raku ]], 'Example 1';

is minimum_index_sum([qw[ A B C ]], [qw[ D E F ]]), [], 'Example 2';

is minimum_index_sum([qw[ A B C ]], [qw[ C A B ]]), ['A'], 'Example 3';
