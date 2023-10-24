#!/usr/bin/env raku

sub acronym(@arr,$check)
{
  (@arr.map: {fc substr $_,0,1}).join eq fc $check;
}

say acronym(["Perl", "Python", "Pascal"],"ppp");
say acronym(["Perl", "Raku"],"rp");
say acronym(["Oracle", "Awk", "C"],"oac");

