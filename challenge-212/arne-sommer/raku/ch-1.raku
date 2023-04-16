#! /usr/bin/env raku

unit sub MAIN ($word where $word ~~ /^<[a..zA..Z]>+$/, *@jump where @jump.all ~~ UInt && @jump.all < 26 && @jump.elems == $word.chars);

for $word.comb -> $letter
{
  my $is-lc = $letter eq any('a' ... 'z');
  my $jump  = @jump.shift;
  my $new   = chr($letter.ord + $jump);

  $new = chr($new.ord - 26) if  $is-lc && $new.ord > 'z'.ord;
  $new = chr($new.ord - 26) if !$is-lc && $new.ord > 'Z'.ord;

  print $new;
}

say "";
