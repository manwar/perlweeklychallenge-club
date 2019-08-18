#! /usr/bin/env perl6

my $e-seq := gather
{
  take 1;

  my $current = 1;

  for 1 .. Inf
  {
    $current /= $_;
    take $current;
  }
}

sub MAIN (:$steps = 10)
{
  say $e-seq[^$steps].sum;
}

