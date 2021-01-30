#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl -s SECTIONS < input-file
#

use Getopt::Long;
use List::Util qw [min];

GetOptions 's=i'  =>  \my $sections;

die "-s option required" unless defined $sections && $sections > 0;

#
# There is no need to split the input string into chunks,
# we can leave it as is. The $i-th character of the $j-th section
# is as position $j * $s_len + $i, where $s_len is the length
# of a section.
#
# (We'll just split into substring, and then ignore them, just to
#  satisfy the condition).
#
# To calculate the minimum number of flips, for each position $i, we
# calculate the number of 0s there are on the $i-th positions of
# each section. Given the number of 0s, we can calculate the number
# of 1s. The minimum number of flips required to get all the bits
# on position equal is the minimum of the number of 0s and the number
# of 1s.
#
# So, to calculate the minimum number of flips, for each postion,
# we sum the minimum of the number of 0s and the number of 1s.
#

while (<>) {
    chomp;
    my $s_len = length () / $sections;
    {
        # Split into substrings, then ignore them as they aren't needed.
        my $pat = ".{$s_len}";
        my @substrings = /$pat/g;
    }
    my $sum = 0;
    for my $i (0 .. $s_len - 1) {
        my $zeros = 0;
        for my $j (0 .. $sections - 1) {
            my $index = $j * $s_len + $i;
            $zeros ++ if substr ($_, $index, 1) eq "0";
        }
        my $ones = $sections - $zeros;
        $sum += min ($zeros, $ones);
    }
    say $sum;
}
