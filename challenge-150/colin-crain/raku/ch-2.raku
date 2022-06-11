#!/usr/bin/env perl6
#
#
#       150-2-no-squares-allowed.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $max = 361 ) ;


my @all-squares =  (2 ... *).map: * ** 2;
my @squares = @all-squares.shift;
my @out;

CANDIDATE: for 1..$max -> $candidate {
    if @all-squares[0] == $candidate {
        @squares.push: @all-squares.shift; 
        next CANDIDATE ;
    }

    $candidate %% $_ and next CANDIDATE for @squares;
    @out.push: $candidate;
}

for @out.rotor(10) {
    .fmt( "%5s", ',').say
}


