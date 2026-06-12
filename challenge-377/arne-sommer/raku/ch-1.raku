#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 1,
               :a(:$all),
               :v(:$verbose) = $all);

my $reverse = $str.flip;
my $match   = False;

for 0 .. $str.chars - 2 -> $i
{
  my $substring = $str.substr($i, 2);

  my $is-match = $reverse.contains($substring);

  say ": '$reverse'.contains('$substring') - { $is-match ?? "Match" !! "not a match" }" if $verbose;

  if $is-match
  {
    $match = True;
    last unless $all;
  }
}

say $match;
