#! /usr/bin/env raku

unit sub MAIN (Str $tree = "1 | 2 4 | 6 4 9 | 5 1 7 2");

my @tree  = $tree.split("|")>>.words;

my @solutions;

traverse(0, 0, 0);

sub traverse($row, $col, $sum is copy)
{
  $sum += @tree[$row][$col];
  
  if @tree[$row+1]
  {
    traverse($row+1, $col,   $sum);
    traverse($row+1, $col+1, $sum);
  }
  else
  {
    @solutions.push: $sum;
  }
}

say @solutions.min;
