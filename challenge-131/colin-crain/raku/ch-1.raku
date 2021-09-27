#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( @input? ) ;


@input.elems == 0 
    && @input = 11, 12, 14, 17, 18, 19;

my @out;
our @subarray = [ @input.shift ];

for @input {
    $_ == @subarray[*-1] + 1
        ?? @subarray.push: $_
        !! do { 
                @out.push: [ |@subarray ] ;
                @subarray = [ $_ ] 
           }
}

@out.push: @subarray;
@out.say;



