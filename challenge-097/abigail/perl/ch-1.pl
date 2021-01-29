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
# Run as: perl ch-1.pl -s SHIFT < input-file
#

my $NR_OF_LETTERS = 26;
my $ORD_A         = ord ('A');

use Getopt::Long;

GetOptions 's=i'  =>  \my $shift;

die "-s SHIFT option required" unless defined $shift;

$shift %= $NR_OF_LETTERS;

while (<>) {
    chomp;
    s {([A-Z])}
      {   my $ch = ord ($1) - $shift;
          $ch += $NR_OF_LETTERS if $ch < $ORD_A;
          chr $ch
      }eg;
    say;
}
