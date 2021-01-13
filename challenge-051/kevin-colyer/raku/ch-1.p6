#!perl6 
# Task 1 Challenge 051 Solution by kevincolyer
# 3 Sum
# Given an array @Lof integers. Write a script to find all unique 
# triplets such that a + b + c is same as the given target T. Also 
# make sure a &lt;= b &lt;= c.
# Here is wiki page for more information.
# Example:
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.
my  @L = -25, -10, -7, -3, 2, 4, 8, 10;


sub uniqueTriplets(@listOfInts,$target) {
    my @L=@listOfInts.sort;
    my $len=@L.elems;
    my @triplets;
    die "List needs to have 3 or more elements - found $len" if $len < 3;
    
    for ^($len-2) -> $i {
        for ($i+1)..^($len-1) -> $j {
            for ($j+1)..^$len -> $k {
                my ($a,$b,$c)=@L[$i,$j,$k];
                @triplets.push: "$a + $b + $c = {$target}" if $a+$b+$c==$target;
            }
        }
    }
    return @triplets;
}

say uniqueTriplets(@L,0).raku;
