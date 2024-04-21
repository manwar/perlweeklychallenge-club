#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ all };

sub completing_word($string, @strings) {
    my $count = _count($string);
    my $cw;
    for my $s (@strings) {
        my $count2 = _count($s);
        if (all { $count->{$_} <= ($count2->{$_} // 0) } keys %$count) {
            $cw = $s if ! defined $cw
                     || length($s) < length($cw);
        }
    }
    return $cw // ""
}

sub _count ($s) {
    my %count;
    my $l = lc $s;
    if (2500 < length $s) {  # This is an optimization for very long strings.
        %count = map {; $_ => eval "\$l =~ tr/$_//" } 'a' .. 'z';
    } else {
        ++$count{$_} for split //, $l =~ s/[^a-z]//gr;
    }
    return \%count
}

use Test2::V0;
plan(3 + 2 + 1);

is completing_word('aBc 11c', 'accbbb', 'abc', 'abbc'), 'accbbb', 'Example 1';
is completing_word('Da2 abc', 'abcm', 'baacd', 'abaadc'), 'baacd', 'Example 2';
is completing_word('JB 007', 'jj', 'bb', 'bjb'), 'bjb', 'Example 3';

is completing_word('abc', 'def', 'ghi', 'jkl'), "", 'No word';
is completing_word('1 2 3', 'a', "", 'xyz'), "", 'No letter';

is _count('a1' x 3000), hash {
    field a => 3000;
    field $_ => 0  for 'b' .. 'z';
    end();
}, 'long string count';
