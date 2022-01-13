#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( *@arr ) {
     for @arr Z @arr.sort {
        say 0 and exit if $_[0] != $_[1];
     }
     say 1;
}
