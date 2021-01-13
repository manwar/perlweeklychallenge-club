#Tries to solve https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/ as perl coding practice.

use strict;
use warnings;
use feature qw(say);
use utf8;
use Getopt::Long;
use List::Util qw(sum first max min);
use Data::Dumper;

my @hist;

GetOptions("histogram=i{1,}", \@hist);

my $count = 1;
my $max = 0;

while (max(@hist) > 0) {
  my @positives = map {$_ > 0} @hist;
  my $l = 0;
  my $maxl =0;
  foreach (@positives) {
    if ($_) {
      ++$l;
    } else {
      $maxl = $l if $l > $maxl;
      $l = 0;
    }
  }
  $maxl = $l if $l > $maxl;
  my $rect = $maxl * $count;
  $max = $rect if $rect > $max;
  @hist = map {$_ - 1} @hist;
 ++$count
}
say $max;
