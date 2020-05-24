use strict;
use warnings;

use Data::Dumper;
#TASK #1 › Product SubArray

#Given a list of 4 or more numbers, write a script to find the contiguous sublist that has the maximum product. 
#The length of the sublist is irrelevant; your job is to maximize the product.
#Example

#Input: [ 2, 5, -1, 3 ]

#Output: [ 2, 5 ] which gives maximum product 10.


my @aOutputs = ();
my @aInput  =(2, 5, -1, 3 );



foreach my $i (0..$#aInput){
    foreach my $l (1..$#aInput+1-$i){
        my @asublist = ();
        push (@asublist, $aInput[$i]);
        foreach my $c  (1..$l-1){
            push (@asublist, $aInput[$i+$c]);
        }
        push ( @aOutputs, \@asublist); 
   }
}

my $maximumProduct = 0;
my @aMaximumProductSublist = ();

foreach my $output (@aOutputs) {
    my $product = getProductArray($output);
    if ($product > $maximumProduct){
        $maximumProduct = $product;
        @aMaximumProductSublist = @{$output};
    }

}

sub getProductArray {
    my $refArray = shift;
    my $productArray = 1;
    foreach my $digit (@{$refArray}){
        $productArray = $digit * $productArray;        
    }
   return $productArray;
}

print "[".join(',',  @aMaximumProductSublist)."] which gives maximum product $maximumProduct\n";