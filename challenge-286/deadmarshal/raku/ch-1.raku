#!/usr/bin/env raku

sub self-spammer()
{
  $?FILE.IO.words.pick
}

say self-spammer();

