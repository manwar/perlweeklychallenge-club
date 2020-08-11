#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

sub throws_divide_by_zero_error {
  my ($numerator, $denominator) = @_;

  eval {
    no warnings 'void';
    $numerator / $denominator;
  };

  if ($@) {
    return $@ =~ /^Illegal division by zero/;
  }

  return;
}

my @numbers = ( 0 .. 10 );

for (1 .. 20) {
  my $num = @numbers[rand @numbers];
  my $den = @numbers[rand @numbers];

  print "Dividing $num by $den ";
  if (throws_divide_by_zero_error($num, $den)) {
    say 'throws a divide by zero error';
  } else {
    say 'is ok';
  }
}
