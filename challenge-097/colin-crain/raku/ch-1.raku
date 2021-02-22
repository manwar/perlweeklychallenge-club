#!/usr/bin/env perl6
#
#
#       et-tu-brute.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $shift = 3, Str $str = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG") ;

$_ = $str;
s:g/ (<[a..zA..Z]>) /{ chr(((ord(uc $0)-65-$shift)%26)+65) }/;

$str.say;
.say;
