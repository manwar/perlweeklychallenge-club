#!/usr/bin/env perl6


say &magical_triplet((1,2,3,2));
#[3 2 2]

say &magical_triplet((1,3,2));
#()

say &magical_triplet((1,1,2,3));
#()

say &magical_triplet((2,4,3));
#(4,3,2)



sub magical_triplet(@n){

    #-- find the three biggest elements (Their sum is max)
    my @candidate = @n.sort({$^b > $^a}).head(3);
    
    #-- test if any element is >= than the sum of the other two
    my $sum=@candidate.sum;
    for (@candidate) -> $i { ($i >= ($sum-$i)) && (return ()) }
    
    #-- if no element is >= the sum of the other two, we are through.
    return @candidate;
}


