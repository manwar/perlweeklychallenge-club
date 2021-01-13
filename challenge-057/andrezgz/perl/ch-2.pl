#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-057/
# Task #2
#
# Shortest Unique Prefix
# Write a script to find the shortest unique prefix for each each word
# in the given list. The prefixes will not necessarily be of the same length.
#
# Sample Input
#     [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
# Expected Output
#     [ "alph", "b", "car", "cadm", "cade", "alpi" ]

use strict;
use warnings;

die "$0 <word1> <word2> ...\n" if @ARGV < 2;

my $input = \@ARGV;
my $l = @$input -1;

my @output;

for my $i (0 .. $l){
    for my $j (1 .. length $input->[$i]){
        my $s = substr $input->[$i],0,$j;
        next if grep { $s eq substr $_,0,$j }
                ( @$input[0 .. $i-1] , @$input[$i+1 .. $l] );
        push @output,$s;
        last;
    }
    push @output,'N/A' if @output != $i+1; #not unique prefix
}

print join ',', @output;

__END__

./ch-2.pl alphabet book carpet cadmium cadeau alpine
alph,b,car,cadm,cade,alpi

./ch-2.pl just another perl hacker
j,a,p,h

./ch-2.pl use uses user
N/A,uses,user
