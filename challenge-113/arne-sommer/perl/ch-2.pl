#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;
use List::Util qw(sum);

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $tree = shift(@$ARGV) // '1 | 2 3 | 4 * 5 6 | * 7';

my $sum = sum(grep(/\d/, split(/\s+/, $tree)));

say ": Sum: $sum" if $verbose;

my @elems;

for my $elem (split(/\s+/, $tree))
{
  $elem =~ /\d/
   ? push(@elems, $sum - $elem)
   : push(@elems, $elem);
}

say join(" ", @elems);
