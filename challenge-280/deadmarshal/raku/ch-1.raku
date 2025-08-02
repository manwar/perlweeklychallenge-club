#!usr/bin/env raku

sub twice-appearance($str)
{
  $str.flip ~~ /.*(.).*?$0/
}

say twice-appearance('acbddbca');
say twice-appearance('abccd');
say twice-appearance('abcdabbb');

