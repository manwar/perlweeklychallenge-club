#!/usr/bin/env raku
use v6;
sub soeb (Int:D $N where 0 <= * <= 255) {$N +& 170 +> 1 +| $N +& 85 +< 1}
put soeb(+$_) for @*ARGS ?? @*ARGS !! <101 18>
