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

die "usage: $0 <file> <letters>\n" unless @ARGV == 2;
my $file    = shift;
my $letters = shift;

# Construct a hash mapping each letter to its count number
my %letters;
++$letters{$_} foreach split //, lc $letters;

# Return true if $word matches %letters
sub match {
    my ($word) = @_;
    my %letters = %letters;
    foreach my $char (split //, lc $word) {
        return 0 unless exists $letters{$char} && $letters{$char}-- > 0;
    }
    return 1;
}

open my $fh, '<', $file;
while (<$fh>) {
    chomp;
    say $_ if match($_);
}
close $fh;
