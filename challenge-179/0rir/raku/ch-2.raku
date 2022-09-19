#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin requirement
Task 2: Unicode Sparkline   Submitted by: Mohammad S Anwar
You are given a list of positive numbers, @n.

Write a script to print sparkline in Unicode for the given list of numbers.

=end requirement

=begin comment
Sparkline will be 16 characters long max.
=end comment

my @graphic = '▁' … '█';
constant SparkMaxLen = 16;
constant SparkMinLen = 2;
constant SparkSteps = 8;

sub sparkline( @n is copy --> Str) {
    die "Refusing to graph @n[]" if @n.elems < SparkMinLen;
    my $bs = my $never-mind = ( 1 => 0);
    my ($min, $max) = @n.min, @n.max;

    my $return = sprintf "min:%5d  max:%5d  data-points: @n.elems() ",
        $min, $max ;

    if @n.elems > SparkMaxLen {    # chunk to length
        $bs = ( @n.elems mod SparkMaxLen) + (@n.elems div SparkMaxLen)
                =>  - (@n.elems mod SparkMaxLen) ;
        @n.=rotor: $bs unless $bs ~~ $never-mind;
        @n.=map: { [+] $_[0..*-1] };
        ($min, $max) = @n.min, @n.max;
    }

    # scale to SparkSteps
    @n.=map: ( (* - $min) ÷ ( ($max - $min) ÷ (SparkSteps -1 ))).Int;
    $return ~=  @graphic[@n].join;
}

constant TEST=False;
if TEST {
    my @Test =
        [ 0, 1, 2, 3, 4, 5, 6, 7, 7, 6, 5, 4, 3, 2, 1, 0 ],

        [ 0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,7,7,6,6,5,5,4,4,3,3,2,2,1,1,0,0 ],
        [ 47, 47, 67, 67, 87, 87, 107, 107, 127, 127, 147, 147, 167, 167,
            187, 187, 187, 187,
            167, 167, 147, 147, 127, 127, 107, 107, 87, 87, 67, 67, 47, 47],

        [ 0,0,0,0,0, 1,1,1,1,1, 2,2,2,2,2, 3,3,3,3,3, 4,4,4,4,4, 5,5,5,5,5,
            6,6,6,6,6, 7,7,7,7,7, 7,7,7,7,7, 6,6,6,6,6, 5,5,5,5,5, 4,4,4,4,4,
            3,3,3,3,3, 2,2,2,2,2, 1,1,1,1,1, 0,0,0,0,0, ],
        [ 0,0,0,0,0, 1,1,1,1,1, 2,2,2,2,2, 3,3,3,3,3, 4,4,4,4,4, 5,5,5,5,5,
            6,6,6,6,6,          7,7,7,7,7,  6,6,6,6,6, 5,5,5,5,5, 4,4,4,4,4,
            3,3,3,3,3, 2,2,2,2,2, 1,1,1,1,1, 0,0,0,0,0, ],

        [ 446, 317,216, 250 ],
        [ 446, 317,216, 250, 57 ],
        [ 446, 446, 317, 317, 216, 216,  250, 250, 57, 57 ],
        [ 785, 311, 925, 535, 726, 195, 76, 558,
            188, 288, 308, 449, 712, 324, 891, 291,
            739, 299, 956, 606, 797, 20, 285, 16,
            194, 90, 690, 612, 97, 987, 922, 120 ],
        [ 343, 491, 341, 863, 407, 482, 272, 905,
            69, 870, 498 ],
        [ 243, 714, 728, 970, 33, 437, 159, 827,
            703, 453, 301, 491, 271, 15, 873, 634 ],
        [ 243, 714, 728, 970, 33, 437, 159, 827,
            703, 453, 301, 491, 271, 15, 873, 634, 625,  ],
        [ 243, 714, 728, 970, 33, 437, 159, 827,
            703, 453, 301, 491, 271, 15, 873, 634, 625, 641,  ],
        [ 243, 714, 728, 970, 33, 437, 159, 827,
            703, 453, 301, 491, 271, 15, 873, 634, 625, 641, 438, ],
        [ 243, 714, 728, 970, 33, 437, 159, 827,
            703, 453, 301, 491, 271, 15, 873, 634, 625, 641, 438, 28, ],
        [ 243, 714, 728, 970, 33, 437, 159, 827,
            703, 453, 301, 491, 271, 15, 873, 634, 625, 641, 438, 28, 371, ],
        [ 243, 714, 728, 970, 33, 437, 159, 827,
            703, 453, 301, 491, 271, 15, 873, 634, 625, 641, 438, 28, 371,
            879, 334, 446,]
    ;
    for @Test -> @t {
        say sparkline( @t ), "\n";
    }
    exit;
}

my @n = [ 243, 714, 728, 970,  33, 437, 159, 827, 703, 453, 301, 491,
          271,  15, 873, 634, 625, 641, 438,  28, 371, 879, 334, 446,];

sub MAIN( ) {
   say sparkline @n;
}

