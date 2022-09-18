#! /usr/bin/env raku

unit sub MAIN ($file where $file.IO.f && $file.IO.r = "paths.txt");

my @paths = $file.IO.lines;

my $first = @paths.shift;

while @paths
{
  my $next = @paths.shift;

  $first = common($first, $next);
}

$first ~~ /(.*)\//; say $0.Str;

sub common ($a, $b)
{
  my $length = min($a.chars, $b.chars);

  for ^$length -> $index
  {
    return $a.substr(0, $index) unless $a.substr($index,1) eq $b.substr($index,1);
  }

  return $a.substr(0, $length);
}
