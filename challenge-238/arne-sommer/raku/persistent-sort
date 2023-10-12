#! /usr/bin/env raku

unit sub MAIN (*@int where all(@int) ~~ UInt && all(@int) > 0 && @int.elems > 0, :v(:$verbose));

my %steps;

for @int -> $int
{
  %steps{$int} = steps($int);
}

say '(' ~ @int.sort({ %steps{$^a} <=> %steps{$^b} || $^a <=> $^b }).join(', ') ~ ')';

sub steps (Int $int is copy)
{
  print ": $int" if $verbose;
  my $steps = 0;
  while $int >= 10
  {
    my @digits = $int.comb;
    $int = [*] @digits;
    print " => { @digits.join(' x ') } => $int" if $verbose;
    $steps++;
  }
  say " ($steps step{ 's' if $steps != 1})" if $verbose;
  return $steps;
}
