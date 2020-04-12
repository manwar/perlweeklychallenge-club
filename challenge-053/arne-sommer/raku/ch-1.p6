#! /usr/bin/env raku

subset Degree where * == any(90, 180, 270);

unit sub MAIN (Degree $degree is copy = 90, :$verbose);

my @matrix = ((1,2,3), (4,5,6), (7,8,9));

while $degree
{
  @matrix = rot90(@matrix);
  $degree -= 90;
}

say @matrix.raku;

sub rot90 (@matrix)
{
  my @new;

  for ^@matrix[0].elems -> $col
  {
    my @row;
    for ^@matrix.elems -> $row
    {
      say ":c ", @matrix[$row][$col] if $verbose;
      @row.push(@matrix[$row][$col]);
    }
    say ":r ", @row.reverse if $verbose;
    @new.push(@row.reverse.list);
  }

  return @new;
}