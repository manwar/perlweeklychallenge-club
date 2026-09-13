#! /usr/bin/env raku

unit sub MAIN (Str $str is copy where $str ~~ /<[a..zA..Z]>/,
               Int $k where $str.chars >= $k > 0,
	       :a(:$all),
               :v(:$verbose) = $all);

my $result;

if $k == 1
{
  my @rotations = map { $str.substr($_) ~ $str.substr(0, $_) },
                      0 ..^ $str.chars;

  say ": rotations: " ~ @rotations.raku if $verbose;

  $result = @rotations.min;

  while $all && $str ne $result
  {
    $str = $str.substr(1) ~ $str.substr(0, 1);

    say ": -> $str" if $verbose;
  }
}
else
{
  $result = $str.comb.sort.join;

  while $all && $str ne $result
  {
    my $index = $str.index($str.substr(0, $k).comb.min);
    
    $str ~= $str.substr($index, 1);

    $str.substr-rw($index, 1) = "";

    say ": index $index -> $str" if $verbose;
  }
}

say $result;
