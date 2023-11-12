#!/usr/bin/env raku

sub flip-matrix(@mat)
{
  @mat.map: {.reverse >>+^>> 1}
}

say flip-matrix([[1,1,0],[1,0,1],[0,0,0]]);
say flip-matrix([[1,1,0,0],[1,0,0,1],[0,1,1,1],[1,0,1,0]]);

