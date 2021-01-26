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
# Run as: perl ch-1.pl -t TIMES < input-file
#

use Getopt::Long;

GetOptions 't=i'  =>  \my $times;

die "-t option required" unless defined $times;

$times %= 26;

while (<>) {
    chomp;
    s/([A-Z])/my $ch = ord ($1) - $times; $ch += 26 if $ch < 65; chr $ch/eg;
    say;
}
