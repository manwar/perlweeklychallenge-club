#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(hj([
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

sub hj($a,$b,$c,$d) {
  my @h=($a,$c);
  my @i=($b,$d);
  my %m;
  for 0,1 -> $x {
    my $j=1-@i[$x];
    for 0..@h[$x].end -> $y {
      unless (%m{@h[$x][$y][@i[$x]]}:exists) {
        %m{@h[$x][$y][@i[$x]]} = [Array.new,Array.new];
      }
      push @(%m{@h[$x][$y][@i[$x]]}[$x]),@h[$x][$y][$j];
    }
  }
  my @o;
  for (%m.keys.sort) -> $k {
    for @(%m{$k}[0]) -> $a {
      for @(%m{$k}[1]) -> $b {
        push @o,[$a,$k,$b];
      }
    }
  }
  return @o;
}
