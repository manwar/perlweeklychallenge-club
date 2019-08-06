#!/usr/bin/env perl
#
# Write a script that can wrap the given paragraph at a specified column using
# the greedy algorithm.
#
# (https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_number_of_lines).
################################################################################

use strict;
use warnings;

my $COLUMN = shift or die "Usage: $0 <column> [file]\n";

my @words;
while (<>) {
    push @words, split " ", $_;
}

my $col = 0;
my @out_line;
for my $word (@words) {
    my $word_len = length $word;
    if ($col + $word_len + 1> $COLUMN && @out_line) {
        print "@out_line\n";
        @out_line = ();
        $col = 0;
    }
    push @out_line, $word;
    $col += $word_len + 1;
}
print "@out_line\n";
