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
# To get the minimum number of flips, for each position take the
# minimum of the number of 0s and the number of 1s, and sum over
# all the positions
#

while (<>) {
    my $sum = 0;
    chomp;
    my @chunks = /.{$sections}/g;
    for (my $i = 0; $i < length $chunks [0]; $i ++) {
        my $zeros = grep {substr ($_, $i, 1) eq "0"} @chunks;
        $sum += min $zeros, @chunks - $zeros;
    }
    say $sum;
}
