#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

# The message
my $message =
'P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0';

# Initialize the columns hash
my @column_hash;
my ($first_line) = split ("\n", $message, 2);
my $length = length(join '', split (" ", $first_line));
$column_hash[$_] = {} for (0..$length-1);

# Parse the cryptic message
for my $line (split ("\n", $message)) {
    my $i = 0;
    for my $char (split (" ", $line)) {
        $column_hash[$i++]->{$char}++;
    }
}

# Sort
for my $column (@column_hash) {
    my @sort =
        sort { $column->{$b} <=> $column->{$a} }
        keys %$column;

    print $sort[0];
}

say '';
