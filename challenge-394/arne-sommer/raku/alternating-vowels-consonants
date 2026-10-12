#! /usr/bin/env raku

subset English where * ~~  /^ <[a..zA..Z]>+ $/;

unit sub MAIN (English $s1, English $s2, English $s3,
               :v(:$verbose));

sub is-vowel(Str $c) { $c.lc ∈ <a e i o u> }

sub alternating-runs(Str $s)
{
  my @runs;
  my $n = $s.chars;

  my $i = 0;
  while $i < $n
  {
    my $j = $i;
    $j++ while $j + 1 < $n
         && is-vowel($s.substr($j, 1)) != is-vowel($s.substr($j + 1, 1));

    @runs.push: $s.substr($i, $j - $i + 1);
    $i = $j + 1;
  }

  @runs;
}

sub alternating-substrings(Str $s)
{
  my @subs;

  for alternating-runs($s) -> $run
  {
    for 0 ..^ $run.chars -> $a
    {
      for 1 .. $run.chars - $a -> $len
      {
        @subs.push: $run.substr($a, $len);
      }
    }
  }

  @subs;
}

my @sets   = map { alternating-substrings($_).Set }, $s1, $s2, $s3;
my @common = (@sets[0] ∩ @sets[1] ∩ @sets[2]).keys;
my $max    = @common.elems ?? @common.map(*.chars).max !! 0;
my @result = @common.grep(*.chars == $max).sort;

if $verbose
{
  for $s1, $s2, $s3 -> $s
  {
    say ": $s -> " ~ alternating-runs($s).join(", ");
  }
  say ": Common: " ~ @common.sort.join(", ") if @common.elems;
  say ": Longest: $max" if $max;
}

say "({ @result.map( '"' ~ * ~ '"' ).join(", ") })";
