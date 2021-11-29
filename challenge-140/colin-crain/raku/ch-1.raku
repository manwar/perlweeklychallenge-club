#!/usr/bin/env perl6
#
#
#       binplus.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Str $bin1 = "1", Str $bin2 = "11" ) ;

## show your work...
# ($bin1.parse-base(2) + $bin2.parse-base(2))                       .base(2).say;
# ($bin1, $bin2).reduce({ $^a.parse-base(2) + $^b.parse-base(2) })  .base(2).say;
# ($bin1, $bin2).reduce({ [+] ($^a,$^b).map({.parse-base(2)}) })    .base(2).say;


([+] ($bin1, $bin2).map({.parse-base(2)}))
    .base(2)
    .say;


 
