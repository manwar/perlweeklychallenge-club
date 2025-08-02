#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub most_frequent_word($p, $w) {
    my %count = ("" => 0);
    my @max = ("");
    while ($p =~ /(\w+)/g) {
        my $match = $1;
        next if $match eq $w;

        if (++$count{$match} >= $count{ $max[0] }) {
            @max = () if $count{$match} > 1 + $count{ $max[0] };
            push @max, $match;
        }
    }
    return \@max
}

use Test2::V0;
plan 3;

is most_frequent_word('Joe hit a ball, the hit ball flew far after it was hit.',
                      'hit'),
    ['ball'], 'Example 1';

is most_frequent_word('Perl and Raku belong to the same family. Perl is the '
                      . 'most popular language in the weekly challenge.',
                      'the'),
    ['Perl'], 'Example 2';

is most_frequent_word('a a b b c c', 'c'), ['a', 'b'], 'More than one';
