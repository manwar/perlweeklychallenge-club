#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = (

    'perl',
    'book',
    'good morning',
);

for my $input (@examples) {
    my $output = split_string($input) ? 'true' : 'false';

    say <<"END";
        Input:  \$str = "$input"
        Output: $output
END
}

sub split_string ($word) {
    my $l = length $word;
    for my $i ( 1 .. $l ) {
        my $first  = substr $word, 0, $i;
        my $second = substr $word, $i, $l - $i;
        my $ff     = scalar grep { is_vowel($_) } split //, $first;
        my $ss     = scalar grep { is_vowel($_) } split //, $second;
        return 1 if $ff == $ss;
    }
    return 0;
}

sub is_vowel ($letter) {
    my @vowels = qw{a e i o u};
    return 1 if grep { $_ eq $letter } @vowels;
    return 0;
}
