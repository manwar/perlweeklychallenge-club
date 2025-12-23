#!/bin/env raku

unit sub MAIN(*@str);

@str .= unique;
put @str.grep(-> $s { +@str.grep(*.contains($s)) > 1 });
