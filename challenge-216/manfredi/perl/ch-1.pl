#!/usr/bin/env perl

use v5.36;

say "challenge-216-task1";

# Task 1: Registration Number
# You are given a list of words and a random registration number.
# Write a script to find all the words in the given list that has every letter in the given registration number.

# Example 1
# Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
# Output: ('abcd')

# Example 2
# Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
# Output: ('job', 'bjorg')

# Example 3
# Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
# Output: ('crack', 'rac')

sub registration_number {
    my $reg = shift;
    my @words = @{+shift};
    my @out = ();
    say "Input: \@words = (@words) , \$reg = '$reg'";
    my %hreg = ();
    my @hreg = grep { /[a-z]/ } split //, lc $reg;
    $hreg{$_} = 1 for @hreg;
    for my $word (@words) {
        my %hword = ();
        $hword{$_} = 1 for (split //, lc $word);
        my @i = grep { exists $hreg{$_} } keys %hword;
        push @out, $word if $#i == $#hreg;
    }
    say "Output: (@out)\n";
}

while (<DATA>) {
    chomp;
    my ($reg, @words) = split ',';
    registration_number($reg, \@words);
}


__DATA__
AB1 2CD,abc,abcd,bcd
007 JB,job,james,bjorg
C7 RA2,crack,road,rac
