#! /usr/bin/env raku

unit sub MAIN ($count = 10);

my $bell-triangle := gather
{
  take 1;
  take 1;
  my @triangle = ((1));
  my $row = 0;

  loop
  {
    $row++;
    my @prev = @triangle[$row-1].flat;
    my @new  = @prev[*-1];

    for ^@prev.elems -> $index
    {
      @new.push: @new[*-1] + @prev[$index];
    }
   
    @triangle.push: @new;

    take @new[*-1];
  }
}

say $bell-triangle[^$count];
