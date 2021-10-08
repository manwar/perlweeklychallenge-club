#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings qw(experimental::signatures);

my $N = $ARGV[0] // die 'Please specify a positive integer';

die "Postive number only" unless $N =~ /^[1-9]\d+$/;

say int_sqare_root($N);

sub int_sqare_root ($number)
{
  my $x0 = $number >> 1;

  if ($x0)
  {
    my $x1 = ( $x0 + $number / $x0 ) >> 1;
		
    while ($x1 < $x0)
    {
      $x0 = $x1;
      $x1 = ( $x0 + $number / $x0 ) >> 1;
    }
    return $x0;
  }
  else
  {
    return $number;
  }
}
