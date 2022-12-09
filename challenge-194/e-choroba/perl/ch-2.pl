#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub frequency_equalizer ($s) {
    return 0 unless length $s;

    my %freq;
    ++$freq{$_} for split //, $s;
    my %by_freq;
    undef $by_freq{ $freq{$_} }{$_} for keys %freq;

    # More than 2 freqs.
    return 0 if keys %by_freq > 2;

    # Single character.
    return 1 if 1 == keys %freq;

    # Too many to remove.
    my @sizes = sort { $a <=> $b } keys %by_freq;
    return 0 if 1 == @sizes                           # xy
             || $sizes[1] - $sizes[0] != 1            # xyyy
             || 1 < keys %{ $by_freq{ $sizes[1] } };  # xyyzz

    return 1
}

use Test::More tests => 3 + 8;

is frequency_equalizer('abbc'),      1, 'Example 1';
is frequency_equalizer('xyzyyxz'),   1, 'Example 2';
is frequency_equalizer('xzxz'),      0, 'Example 3';

is frequency_equalizer('aaaabbbcc'), 0, 'More than two freqs';
is frequency_equalizer('aabbcd'),    0, 'Too many instances';
is frequency_equalizer('aabbccd'),   0, 'Too many to remove';
is frequency_equalizer('xxzzzz'),    0, 'Difference too large';
is frequency_equalizer(""),          0, 'Empty string';
is frequency_equalizer('a'),         1, 'Single character';
is frequency_equalizer('aaaa'),      1, 'Single character repeated';
is frequency_equalizer('abcdd'),     1, 'Many instances';
