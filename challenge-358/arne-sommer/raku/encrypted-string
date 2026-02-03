#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[a..z]>+ $/,
               UInt $int);

say $str.comb>>.&rotate($int).join;

sub rotate($char, $offset)
{
  my $code = $char.ord + $offset;

  $code -= 26 while $code > 'z'.ord;

  return $code.chr;
}
