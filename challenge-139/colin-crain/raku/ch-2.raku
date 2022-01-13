#!/usr/bin/env perl6
#
#
#       longpork.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##












unit sub MAIN () ;


for ( 2..3000 ) {
    my ($real, $reptend) = (1/$_).base-repeating(10);
    $reptend.chars == $_ - 1  
        ??  printf "%5d    %s \n", $_, $reptend
        !!  next    ;
}
    
