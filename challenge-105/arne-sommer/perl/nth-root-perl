#! /usr/bin/env perl

use strict;
use warnings;

use feature 'signatures';
use feature 'say';
use Getopt::Long;

no warnings qw(experimental::signatures);

my $N          = 0;
my $k          = 0;
my $iterations = 10;
my $best       = 0;
my $verbose    = 0;

GetOptions("N=i" => \$N,
           "k=i" => \$k,
	   "i=i" => \$iterations,
	   "b" => \$best,
	   "v" => \$verbose);

my $start = 1;

$start++ while ($start + 1) ** $N < $k;

say ": Start: $start" if $verbose;

my @seq; $seq[0] = $start;

sub get_iteration ($index)
{
  unless (defined $seq[$index])
  {
     $seq[$index] = (1/$N) * ( ($N - 1) * get_iteration($index -1) + ($k / get_iteration($index -1) ** ($N - 1) ));
  }
  return $seq[$index] 
}

if ($best)
{
  my $index = 0;
  my $current = get_iteration($index++);
  $current = get_iteration($index++) while $current != get_iteration($index);
  
  say ": ", join(" | ", @seq) if $verbose;

  say $seq[$index];
}
else
{
  my $value = get_iteration($iterations -1);
  say ": ", join(" | ", @seq) if $verbose;

  say $value;
}
