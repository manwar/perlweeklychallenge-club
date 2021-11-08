#!/usr/bin/env perl6
#
#
#       126-1-no-one-home.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $number = 5 ) ;


say (2..$number).grep({ !/1/ })
                .elems;
        

 


