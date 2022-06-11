#!/usr/bin/env perl6
#
#
#       facts-left-to-the-reader.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $num  = 50 ) ;

say [+] map { [*] 1..$_ }, ^$_ for 0..$num;
