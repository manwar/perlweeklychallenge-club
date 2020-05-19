#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

# You are given a string containing only digits (0..9). The string should have between 4 and 12 digits.
# Write a script to print every possible valid IPv4 address that can be made by partitioning the input string.
# For the purpose of this challenge, a valid IPv4 address consists of four “octets” i.e. A, B, C and D, separated by dots (.).
# Each octet must be between 0 and 255, and must not have any leading zeroes. (e.g., 0 is OK, but 01 is not.)
for my $partition (glob "{1,2,3}" x 3) {
    my ($input,$ip) = ($ARGV[0] || '25525511135');
    for my $x ($partition=~/./g) {
        my $num = substr $input,0,$x;
        last if $num > 255 or $num=~/^0./;
        $input = substr $input,$x;
        $ip.="$num.";
    }
    if ($input ne '' && $input < 256 && $input!~/^0./) {
        say "$ip$input";
    }
}
=begin
perl .\ch-2.pl
255.255.11.135
255.255.111.35

perl .\ch-2.pl 19216800
19.216.80.0
192.16.80.0
192.168.0.0

perl .\ch-2.pl 19216200
1.9.216.200
1.92.16.200
19.2.16.200
19.21.6.200
19.216.20.0
192.1.6.200
192.16.20.0
192.162.0.0
=cut