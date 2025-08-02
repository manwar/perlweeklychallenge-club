#!/usr/bin/env raku

sub uncommon-words($s1,$s2)
{
  my %h;
  %h{lc $_}++ for split /\W+/, $s1 ~ ' ' ~ $s2;
  (%h.keys.grep: {%h{$_} == 1}).sort
}

say uncommon-words('Mango is sweet','Mango is sour');
say uncommon-words('Mango Mango','Orange');
say uncommon-words('Mango is Mango','Orange is Orange');

