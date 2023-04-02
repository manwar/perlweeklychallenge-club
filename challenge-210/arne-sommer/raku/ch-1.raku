#! /usr/bin/env raku

unit sub MAIN (*@int where @int.elems > 0 && @int.all ~~ UInt, :v($verbose));

my $min = @int.min + 1;
my $max = @int.max - 1;

my $score = -Inf;  
my $target;

for $min .. $max -> $value
{ 
  my $sum = @int.grep({ $value -1 <= $_ <= $value +1 }).sum;
  
  if $sum > $score
  {
    $target = $value;
    $score  = $sum;
    say ": + $value with sum $sum" if $verbose;
  }
  elsif $verbose
  {
    say ": - $value with sum $sum";
  }
  
}

say $score;
