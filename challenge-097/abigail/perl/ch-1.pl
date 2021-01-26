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
# Run as: perl ch-1.pl -s TIMES < input-file
#

use Getopt::Long;

GetOptions 's=i'  =>  \my $shift;

die "-s option required" unless defined $shift;

$shift %= 26;

while (<>) {
    chomp;
    s/([A-Z])/my $ch = ord ($1) - $shift; $ch += 26 if $ch < 65; chr $ch/eg;
    say;
}
