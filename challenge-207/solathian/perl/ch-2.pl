#!usr/bin/perl
use v5.36;

# Challenge 207 - 2 - H index

# The H-Index is the largest number h such that h articles have at least h citations each. 
# For example, if an author has five publications, with 9, 7, 6, 2, and 1 citations (ordered from greatest to least), then the author’s h-index is 3, because the author has three publications with 3 or more citations. 
# However, the author does not have four publications with 4 or more citations.


hIndex(9, 7, 6, 2);         #  3
hIndex(10, 8, 5, 4, 3);     #  4
hIndex(25, 8, 5, 3, 3);     #  3
hIndex(1, 1, 1, 1, 1);      #  1
hIndex(2, 2);               #  2

sub count($threshold, $arrRef)
{
    my $count = 0;
    
    map{$count++    if($_ >= $threshold)} @$arrRef;
    
    return $count;
}

sub hIndex(@publications)
{
    my $h = $publications[0]+1;   # consider it already sorted
    
    do
    {
        $h--
    }
    while( $h > count($h, \@publications));


    say $h;
}