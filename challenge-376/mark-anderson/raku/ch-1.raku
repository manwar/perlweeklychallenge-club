#!/usr/bin/env raku
use Test;

ok  chessboard-squares("a7", "f4");
nok chessboard-squares("c1", "e8");
nok chessboard-squares("b5", "h2");
ok  chessboard-squares("f3", "h1");
nok chessboard-squares("a1", "g8");

sub chessboard-squares($c1 is copy, $c2 is copy)
{
    ($c1, $c2).map: { $_ .= trans("aceg1357" => 0, "bdfh2468" => 1) }
    0|3 == $c1.parse-base(2) +^ $c2.parse-base(2)
}
