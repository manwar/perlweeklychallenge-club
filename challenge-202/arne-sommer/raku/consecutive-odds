#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems && all(@array) ~~ /^\-?<[0..9]>*$/, :v(:$verbose));

my $consecutive = 0;
my $start_index = 0;

for ^@array.elems -> $i
{
  if (@array[$i] %% 2)
  {
    $consecutive = 0;
    $start_index++;
  }
  else
  {
    $consecutive++;
  }

  if ($consecutive == 3)
  {
    say ":Consecutives: [{ @array[$start_index .. $start_index+2].join(",") }] starting at undex $start_index" if $verbose;
    say 1;
    exit;
  }
}

say 0;
