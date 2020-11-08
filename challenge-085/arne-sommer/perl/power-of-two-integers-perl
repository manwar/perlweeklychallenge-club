#! /usr/bin/env perl

use strict;
use feature 'say';

use Getopt::Long;
use Math::Prime::Util 'factor';
use List::MoreUtils 'duplicates';

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my $N = $ARGV[0] // die "Please specify a number";

my @factors  = factor($ARGV[0]);
my @repeated = duplicates(@factors);

if ($verbose)
{
  say ": Factors: ",  join(", ", @factors);
  say ": Repeated: ", join(", ", @repeated);
}

say @repeated ? 1 : 0;
