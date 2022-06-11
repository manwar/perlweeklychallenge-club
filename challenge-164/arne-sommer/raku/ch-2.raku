#! /usr/bin/env raku

unit sub MAIN (:l(:$limit) = 8,
               :d(:$delta) = 100,
               :v(:$verbose));

my @result;

for 1 .. * -> $number
{
  my $n = $number;
  my $i = $delta;
  
  while $n != 1 && $i > 0 
  {
    $n = happy($n);
    $i--;
  }

  if $verbose
  {
    say $n == 1
      ?? ": $number is happy (in { 100 - $i } step(s))"
      !! ": $number is not happy";
  }
  
  @result.push($number) if $n == 1;
  
  last if @result.elems == $limit;
}

say @result.join(", ");

sub happy ($number)
{
  return $number.comb.map( * ** 2).sum;
}
