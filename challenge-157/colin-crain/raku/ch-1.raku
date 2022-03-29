#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( *@list ) ;

.say for
    @list.sum / @list.elems,                            ## arithmetic
    @list.reduce({$^a * $^b})  ** (1/ @list.elems),     ## geometric
    @list.elems / ( sum map { 1/$_ }, @list );          ## harmonic


