#!/usr/bin/env perl6
#
#
#       padovans-dog.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ($max = 13) ;

my @pav = 1,1,1;
my @out;

while @out.elems < $max {
    @pav.push( @pav[1] + @pav.shift ) ;
    next if @out.elems and @pav[2] == @out[*-1];
    @pav[2].is-prime && @out.push: @pav[2] ;
}

.say for @out;


