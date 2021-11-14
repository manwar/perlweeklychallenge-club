#! /usr/bin/perl

use strict;

use Test::More tests => 1;

is_deeply(hj([
  [20, "Alex" ],
  [28, "Joe" ],
  [38, "Mike" ],
  [18, "Alex" ],
  [25, "David" ],
  [18, "Simon" ],
    ],
             1,
             [
               ["Alex", "Stewart"],
               ["Joe", "Root" ],
               ["Mike", "Gatting"],
               ["Joe", "Blog" ],
               ["Alex", "Jones" ],
               ["Simon","Duane" ],
                 ],
             0,
               ),[
                 [ 20, "Alex", "Stewart"],
                 [ 20, "Alex", "Jones"],
                 [ 18, "Alex", "Stewart"],
                 [ 18, "Alex", "Jones"],
                 [ 28, "Joe", "Root" ],
                 [ 28, "Joe", "Blog"],
                 [ 38, "Mike", "Gatting"],
                 [ 18, "Simon", "Duane"],
                   ],'example 1');

sub hj {
  my @h;
  my @i;
  ($h[0],$i[0],$h[1],$i[1])=@_;
  my %m;
  foreach my $x (0,1) {
    my $j=1-$i[$x];
    foreach my $y (0..$#{$h[$x]}) {
      push @{$m{$h[$x][$y][$i[$x]]}[$x]},$h[$x][$y][$j];
    }
  }
  my @o;
  foreach my $k (sort keys %m) {
    foreach my $a (@{$m{$k}[0]}) {
      foreach my $b (@{$m{$k}[1]}) {
        push @o,[$a,$k,$b];
      }
    }
  }
  return \@o;
}
