#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util qw/sum/;
use Getopt::Long;

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my $N = $ARGV[0] // die "Specify a positive integer";

die "Not a positive integer" unless $N =~ /^[1-9]\d*$/;

my $ones = sum(split(//, sprintf('%b', $N)));

if ($verbose)
{
  say ": Initial value: $N (binary: ", sprintf('%b', $N) , ")";
  say ": - Number of one bits: $ones";
}

while ($N += 1)
{
  say ": Candidate $N (binary: ", sprintf('%b', $N), ")" if $verbose;

  if (sum(split(//, sprintf('%b', $N))) == $ones)
  {
    say $N;
    exit;
  }
}
