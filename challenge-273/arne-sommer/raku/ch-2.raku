#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0);

if $str ~~ /b/
{
  my $after = $str.split(/b/, 2)[1];

  if $after !~~ /a/
  {
    say 'true';
    exit;
  }
}

say 'false';
