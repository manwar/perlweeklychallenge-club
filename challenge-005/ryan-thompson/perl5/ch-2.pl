#!/usr/bin/env perl
#
# ch-2.pl - Print "string of characters" with the most anagrams
#
# 2019 Ryan Thompson <rjt@cpan.org>

# There's some ambiguity in the challenge description. I do not know what
# "a sequence of characters" means in the context of this challenge, so I'm
# going to write some general functions and then turn that into a specific
# example. The general functions could, however, be used to analyze just
# about any sequence of characters.

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use feature 'fc';
use List::Util qw< max >;

# All the smarts are in the dictionary. We key on the sorted list of chars,
# and append the original word to an array ref in the value. Thus all anagrams
# of each other will have the same hash key.
my %dict;
for (<STDIN>) {
    chomp;
    my $key = join '', sort split '', fc;
    $dict{$key} //= [ ];
    push @{$dict{$key}}, fc($_);
};

# This gives all results in the event of a tie (the case with my dict)
my $max = max map { scalar @$_ } values %dict;
say for map { "<@$_>" } grep { @$_ == $max } values %dict;
