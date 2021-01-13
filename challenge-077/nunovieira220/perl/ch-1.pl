#!/usr/bin/perl

use strict;
use warnings;
use Storable qw(dclone);

# Input
my $N = scalar @ARGV ? $ARGV[0] : 9;
my %aux = ();
$aux{$N} = [];

# Fibonacci sum
my $i = 2;
while(1) {
  my $f = fib($i);
  last if($f > $N);

  for my $key (keys %aux) {
    my $sum = $f + $key;
    next if($sum > $N);

    $aux{$sum} = () if(!$aux{$sum});

    my @matrix = @{dclone($aux{$key})};
    for my $line (@matrix) {
      my @arr = @{$line};
      if (!(grep(/^$f$/, @arr))) {
        push @arr, $f;
        push @{$aux{$sum}}, \@arr;
      }
    }

  }

  push @{$aux{$f}}, [$f];
  $i++;
}

# Output
print "0s" if (scalar @{$aux{$N}} == 0);
for my $c (@{$aux{$N}}) {
  print(join(" + ", @{$c})."\n");
}

# Get fibonacci numbers
sub fib {
  my $n = shift;
  return 1 if ($n == 1 || $n == 2);
  return fib($n - 1) + fib($n - 2);
}