#!/usr/bin/env perl

# You are given a file containing a list of words (case insensitive 1 word per
# line) and a list of letters. Print each word from the file than can be made
# using only letters from the list. You can use each letter only once (though
# there can be duplicates and you can use each of them once), you don’t have to
# use all the letters. (Disclaimer: The challenge was proposed by Scimon
# Proctor)

use 5.026;
use strict;
use autodie;
use warnings;
use List::Util 'all';

my $letters = shift or die "usage: $0 <letters> [<wordsfile>...]\n";

# Construct a hash mapping each letter to its count number
my %letters;
++$letters{$_} foreach split //, lc $letters;

say foreach grep {
    chomp;
    my %letters = %letters;
    --$letters{$_} foreach split //, lc $_;
    all {$_ >= 0} values %letters;
} <>;
