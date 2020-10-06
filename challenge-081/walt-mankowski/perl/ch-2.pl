#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# You are given file named input.
#
# Write a script to find the frequency of all the words.
#
# It should print the result as first column of each line should be
# the frequency of the the word followed by all the words of that
# frequency arranged in lexicographical order. Also sort the words in
# the ascending order of frequency.
#
# For the sake of this task, please ignore the following in the input file:
#
# . " ( ) , 's --

my %h;

while (<>) {
    chomp;
    s/--/ /;
    my @tok = split / /;
    for my $tok (@tok) {
        $tok =~ s/[."(),]//g;
        $tok =~ s/'s$//;
        $h{$tok}++;
    }
}

my $last = 0;
for my $k (sort { $h{$a} <=> $h{$b} || $a cmp $b } keys %h) {
    if ($h{$k} != $last) {
        print "\n" unless $last == 0;
        print $h{$k};
        $last = $h{$k};
    }
    print " $k";
}

print "\n";

