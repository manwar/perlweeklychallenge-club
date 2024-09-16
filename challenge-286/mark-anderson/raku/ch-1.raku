#!/usr/bin/env raku

say self-spammer();

sub self-spammer
{
    $*PROGRAM.words.pick
}
