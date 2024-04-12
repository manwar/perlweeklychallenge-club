#! /usr/bin/env raku

unit sub MAIN (Str $str where $str ~~ /^<[a..z A..Z]>+$/,
               :v(:$verbose));

my $h = $str.comb.Bag;

say ": Bag: { $h.raku }" if $verbose;

for 'Z' ... 'A' -> $letter
{
  say ": Checking $letter" if $verbose;

  if $h{$letter} && $h{$letter.lc}
  {
    say $letter;
    exit;
  }
}

say "";
