#! /usr/bin/env perl6

unit sub MAIN (Int $size where $size > 0);

my @im[$size;$size] = 0 xx $size xx $size;

@im[$_;$_] = 1 for ^$size;

print @im.&nice-format;

sub nice-format (@shaped)
{
  my ($row, $col) = @shaped.shape;

  my $result;

  for ^$row -> $x
  {
    for ^$col -> $y
    {
      $result ~= @shaped[$x;$y] ~ " ";
    }
    $result ~= "\n";
  }
  return $result;
}