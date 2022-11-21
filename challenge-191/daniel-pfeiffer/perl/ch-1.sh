#!/bin/sh

type pl > /dev/null 2>&1 || {
  echo This uses pl, the much enhanced perl one-liner wrapper!  Install it as App::pl.
  echo See details on https://perl1liner.sourceforge.io/
  exit 1
}

echo See details on https://perl1liner.sourceforge.io/Perl-Weekly-Challenge/#2022-11-20

pl -oA '$a = -INF; 1..4' -E 'echo $a >= $b * 2 ? 1 : -1' '$b = $a, $a = $_ if $_ > $a'
pl -oA '$a = -INF; (1,2,0,5)' -E 'echo $a >= $b * 2 ? 1 : -1' '$b = $a, $a = $_ if $_ > $a'
pl -oB '$a = -INF' -E 'echo $a >= $b * 2 ? 1 : -1' '$b = $a, $a = $_ if $_ > $a' 2 6 3 1
pl -oB '$a = -INF' -E 'echo $a >= $b * 2 ? 1 : -1' '$b = $a, $a = $_ if $_ > $a' 4 5 2 3
