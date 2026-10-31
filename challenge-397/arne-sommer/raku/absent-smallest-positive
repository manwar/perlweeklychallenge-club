#! /usr/bin/env raku

unit sub MAIN (*@arr where @arr.elems > 0 && all(@arr) ~~ Int,
               :v(:$verbose));

my $average = @arr.sum / @arr.elems;
my %seen    = @arr.map: * => 1;
my $n       = max($average.Int + 1, 1);

say ": Average is $average" if $verbose;

while %seen{$n}
{
  say ": $n is in the array" if $verbose;
  $n++;
}

say ": $n is not in the array" if $verbose;

say $n;