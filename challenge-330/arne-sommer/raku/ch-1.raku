#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[ a..z 0 .. 9 ]>+$/,
               :v(:$verbose));

my @output;

for $str.comb -> $current
{
  if $current eq any(0..9)
  {
    @output.pop;
    say ": Digit $current; Remove letter -> { @output.join}" if $verbose;
  }
  else
  {
    @output.push: $current;
    say ": Letter $current; Added -> { @output.join}" if $verbose;
  }
}

say @output.join;