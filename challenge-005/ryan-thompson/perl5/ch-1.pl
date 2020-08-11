#!/usr/bin/env perl
#
# ch-1.pl - Print all anagrams of a given word
#
# 2019 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use feature 'fc';

# Dictionary creation is O(n) on number of words. Anagram lookup is O(1).

my %dict;
for (<STDIN>) {
    chomp;
    my $key = join '', sort split '', fc;
    $dict{$key} //= [ ];
    push @{$dict{$key}}, fc($_);
};

my $word = shift // die "Usage: $0 <word>";
my $word_key = join '', sort split '', fc($word);

say for sort @{ $dict{$word_key} // die "$word is not in dictionary" };
