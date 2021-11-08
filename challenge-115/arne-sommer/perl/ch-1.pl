#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Algorithm::Combinatorics 'permutations';
use feature 'signatures';

no warnings qw(experimental::signatures);

my $verbose = 0;

GetOptions("verbose" => \$verbose);

die "At least two strings" unless @ARGV > 1;

for my $list (permutations(\@ARGV))
{
  my @perm = @$list;

  say ": perm: " . join(", ", @perm) if $verbose;
  
  if (is_circle(@perm))
  {
    say 1;
    exit;
  }
}

say 0;

sub is_circle (@list)
{
  my $first       = shift(@list);
  my $first_start = substr($first, 0,1);
  my $second;

  while (@list)
  {
    $second = shift(@list);
    return 0 if substr($first,-1,1) ne substr($second,0,1);
    $first  = $second;
  }
    
  return 1 if $first_start eq substr($second,-1,1);
  return 0;
}


