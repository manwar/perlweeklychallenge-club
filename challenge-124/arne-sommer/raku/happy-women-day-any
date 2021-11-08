#! /usr/bin/env raku

unit sub MAIN (Str $char where $char.chars == 1);

"
    ^^^^^
   ^     ^
  ^       ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
  ^       ^
   ^     ^
    ^^^^^
      ^
      ^
      ^
    ^^^^^
      ^
      ^
".subst('^', $char, :g).substr(1).print;
