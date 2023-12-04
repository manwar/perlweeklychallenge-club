#!/usr/bin/env raku
use v6;
use Test;

=begin comment
245-2: Largest of Three             Submitted by: Mohammad S Anwar

You are given an array of integers >= 0.
Write a script to return the largest number formed by concatenating some of
the given integers in any order which is also multiple of 3. Return -1 if
none found.

Example 1
Input: @ints = (8, 1, 9)
Output: 981

981 % 3 == 0
Example 2
Input: @ints = (8, 6, 7, 1, 0)
Output: 8760

Example 3
Input: @ints = (1)
Output: -1
=end comment

my @Test =
    (1,),               -1,
    (2,5,),             -1,
    (),                 -1,
    (4,235),            -1,
    (63, 9, 39, 3, 30000,1,),   96339330000,
    (63, 9,1,),         963,
    (93, 6),            936,
    (8, 1, 9),          981,
    (3,),               3,
    (1, 6, 7, 8, 0),    8760,
    (3,9),              93,
    (3,3),              33,
    (8, 6, 7, 1, 0),    8760,
    (1,1,1,1,1,1),      111111,
    (1,12,9,14),        914121,
    (1,2,3,4,5,10,11,12,13,14,15,16,17,18,19,20,21), 
            54322120191817161514131211110,
    (1,1,2,3,4,5,10,11,12,13,14,15,16,17,18,19,20,21), 
            54322120191817161514131211110,
;
plan @Test ÷ 2;

# Compare common positive numbers, i.e. 123, so that Order::More indicates
# which should come first to create the greater number when concatenated.
sub cat-cmp( Any:D $a, Any:D $b ) {   # naming?  salvage from challenge 217-2
    my @a = $a.comb.Array;   
    my @b = $b.comb.Array;   
    my $span = (@a.elems, @b.elems).min;
    for ^$span -> $i  {
        my $o =  @a[$i] <=> @b[$i];
        if ? $o { return $o }               # Order::Same.Bool is False
    }

    given +@a <=> +@b {
        when Same { return Same }
        when More {
           return cat-cmp @a[$span..*].join, @b.join;
        }
        when Less {
           return cat-cmp @a.join, @b[$span..*].join;
        }
    }
}

# concat a list of common positive numbers to make the largest number.
multi max-number( Int $a -->Int ) { $a };
multi max-number(  @a -->Int) {
    (@a.sort: { cat-cmp $^b.Int, $^a.Int } ).join.Int;
}

multi func( @a = () ) { -1 }
multi func( @a) {
    my @trey = @a.combinations(1..*).grep( *.sum %% 3);
    my $long = (@trey.map( *.join.chars)).max;
    -∞ == (my $ret = max @trey.grep(
            *.join.chars == $long).map( *.&max-number))
       ?? -1
       !! $ret;
}

multi func1( @a = () ) { -1 }
multi func1( @a ) {
    my @trey = @a.combinations(1..*).grep( *.sum %% 3);
    my %by-size = @trey.classify: { .join.chars };
    my @result;

    for %by-size.keys.sort( { $^b <=> $^a } ) -> $k {
        for %by-size{$k}.values -> @v {
            @result.push: @v.&max-number;
        }
        next without @result;
        return @result.max;
    }
    return -1;
}

for @Test -> $in, $exp {
    #is func($in), $exp, "$exp\t<= @$in[].raku()";
    is func1($in), $exp, "$exp\t<= @$in[].raku()";
}

my @int = (63, 9, 39, 3, 30000,1,);
say "\nInput: @int = @int[]\n Output: &func(@int)";

done-testing;
exit;

