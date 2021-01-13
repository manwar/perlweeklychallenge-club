#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);

# TASK #2 › Letter Phone
# Submitted by: Mohammad S Anwar
#
# You are given a digit string $S. Write a script to print all
# possible letter combinations that the given digit string could
# represent.

# store the letters for each digit as a hash of arraryrefs
my %key = (1 => [qw(_ @)],
           2 => [qw(A B C)],
           3 => [qw(D E F)],
           4 => [qw(G H I)],
           5 => [qw(J K L)],
           6 => [qw(M N O)],
           7 => [qw(P Q R S)],
           8 => [qw(T U V)],
           9 => [qw(W X Y Z)],
           0 => [' ']
          );

my $s = $ARGV[0];
gen_combs($s, 0, '');

# generate the combinations by using recursion to loop over all the
# possible values
sub gen_combs($s, $idx, $prefix) {
    if ($idx == length($s)) {
        say $prefix;
    } else {
        my $digit = substr($s, $idx, 1);
        for my $c ($key{$digit}->@*) {
            gen_combs($s, $idx+1, $prefix . $c);
        }
    }
}
