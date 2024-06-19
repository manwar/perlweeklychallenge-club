#!/usr/bin/env raku

sub percentage-of-character($str,$c)
{
  my $count = $str.comb($c).elems;
  round(100 * $count / $str.chars)
}

say percentage-of-character('perl','e');
say percentage-of-character('java','a');
say percentage-of-character('python','m');
say percentage-of-character('ada','a');
say percentage-of-character('ballerina','l');
say percentage-of-character('analitik','k');

