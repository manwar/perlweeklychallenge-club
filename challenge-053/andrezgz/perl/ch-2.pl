#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/
# Task #2
#
# Vowel Strings
# Write a script to accept an integer 1 <= N <= 5 that would print all possible
# strings of size N formed by using only vowels (a, e, i, o, u).
#
# The string should follow the following rules:
# 'a' can only be followed by 'e' and 'i'.
# 'e' can only be followed by 'i'.
# 'i' can only be followed by 'a', 'e', 'o', and 'u'.
# 'o' can only be followed by 'a' and 'u'.
# 'u' can only be followed by 'o' and 'e'.
# For example, if the given integer N = 2 then script should print the following strings:
#
# ae
# ai
# ei
# ia
# io
# iu
# ie
# oa
# ou
# uo
# ue

use strict;
use warnings;

die "USAGE: $0 <N-string-size>"
    unless @ARGV == 1 && $ARGV[0] =~ /^[1-5]$/;
my $n = shift;

my %vowels = (
    a => ['e','i'],
    e => ['i'],
    i => ['a', 'e','o','u'],
    o => ['a','u'],
    u => ['o','e']
);

my @comb = keys %vowels;
@comb = add_vowel(@comb) for (2..$n);
print $_.$/ for sort @comb;

sub add_vowel {
    my @output;

    for my $c (@_) {
        my $v = substr $c, -1;
        push @output, map { $c . $_ } @{$vowels{$v}};
    }

    return @output
}

__END__
./ch-2.pl 3
aeiS
aia
aie
aio
aiu
eia
eie
eio
eiu
iae
iai
iei
ioa
iou
iue
iuo
oae
oai
oue
ouo
uei
uoa
uou
