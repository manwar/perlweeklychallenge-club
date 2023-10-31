#! /usr/bin/env raku

unit sub MAIN ($chk, *@str where @str.elems > 0);

say @str>>.substr(0,1).join.lc eq $chk.lc
  ?? 'true'
  !! 'false';
