#! /usr/bin/env raku

unit sub MAIN ($str is copy where $str ~~ /^<[0..9]>+/,
               Int $int where $int > 1 && $str.chars > $int,
	       :v($verbose));

while $str.chars > $int
{
  my @parts = partition($str, $int);
  my @sums  = @parts>>.comb>>.sum;
  my $sum   = @sums.join;

  say ": String: $str Parts: { @parts.join(", ") } -> { @sums.join(", ") } -> $sum" if $verbose;

  $str      = $sum;
}

say $str;

sub partition ($str is copy, $length)
{
  my @parts = gather
  {
    while $str.chars
    {
      my $size = min($length, $str.chars);
      take $str.substr(0, $size);
      $str = $str.substr($size);
    }
  } 

  return @parts;
}

