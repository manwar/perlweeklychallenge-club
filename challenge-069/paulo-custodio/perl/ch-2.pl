#!/usr/bin/env perl

# Challenge 069
#
# TASK #2 › 0/1 String
# Submitted by: Mohammad S Anwar
# A 0/1 string is a string in which every character is either 0 or 1.
#
# Write a script to perform switch and reverse to generate S30 as described
# below:
#
# switch:
#
# Every 0 becomes 1 and every 1 becomes 0. For example, “101” becomes “010”.
#
# reverse:
#
# The string is reversed. For example, "001” becomes “100”.
# UPDATE (2020-07-13 17:00:00):
# It was brought to my notice that generating S1000 string would be nearly
# impossible. So I have decided to lower it down to S30. Please follow the rule
# as below:
#
# S0 = “”
# S1 = “0”
# S2 = “001”
# S3 = “0010011”
#
# SN = SN-1 + “0” + switch(reverse(SN-1))

# Note: modified to S20, as S30 was taking forever

use Modern::Perl;

my $N = 20;

sub bits_switch {
    my($s) = @_;
    $s =~ tr/01/10/;
    return $s;
}

sub bits_reverse {
    my($s) = @_;
    return join('', reverse split('', $s));
}

my $prev = "";
my $s;
for (1..$N) {
    $s = $prev."0".bits_switch(bits_reverse($prev));
    $prev = $s;
}
say $s;
