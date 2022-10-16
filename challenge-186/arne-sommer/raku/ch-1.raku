#! /usr/bin/env raku

my @a    = qw/1 2 3/;
my @b    = qw/a b c/;
my @zip1 = my-zip(@a, @b);
my @zip2 = my-zip(@b, @a);

say "qw/@zip1[]/;"; 
say "qw/@zip2[]/;"; 

sub my-zip (@a is copy, @b is copy)
{
  my @return;

  while @a
  {
    @return.push: @a.shift;
    @return.push: @b.shift;
  }

  return @return;
}
