use strict;
use warnings;
use Data::Dumper;
#Flip Binary

#You are given a binary number B, consisting of N binary digits 0 or 1: s0, s1, …, s(N-1).

#Choose two indices L and R such that 0 ≤ L ≤ R < N and flip the digits s(L), s(L+1), …, s(R).
#By flipping, we mean change 0 to 1 and vice-versa.

#For example, given the binary number 010, the possible flip pair results are listed below:

#   L=0, R=0 the result binary: 110
#   L=0, R=1 the result binary: 100
#   L=0, R=2 the result binary: 101
#   L=1, R=1 the result binary: 000
#   L=1, R=2 the result binary: 001
#   L=2, R=2 the result binary: 011

#Write a script to find the indices (L,R) that results in a binary number with maximum number of 1s. 
#If you find more than one maximal pair L,R then print all of them.

#Continuing our example, note that we had three pairs (L=0, R=0), (L=0, R=2), and (L=2, R=2) 
#that resulted in a binary number with two 1s, which was the maximum. So we would print all three pairs.

my $binaryNumber = $ARGV[0];


unless (defined($binaryNumber) && $binaryNumber =~  /^[01]+$/){
    die "ERROR: Script accepts a binary number\n";
}
print "Binary Number :$binaryNumber\n";
my @aResults = ();
my $n = length($binaryNumber);

foreach my $leftIndex (0..$n-1){
    foreach my $rightIndex ($leftIndex..$n-1){
        my $resultBinary =  flipBetween( $leftIndex , $rightIndex) ;
        my $totalOnes = () = $resultBinary =~ /1/g;
        push (@aResults,{'L' => $leftIndex, 'R' => $rightIndex , 'B' => $resultBinary ,'1' =>  $totalOnes} );        
    }
}

my $maxNumberOnes ;
foreach my $result ( sort { $b->{'1'} <=>  $a->{'1'} } @aResults){
    if (defined($maxNumberOnes) && $maxNumberOnes > $result->{'1'} ){
        last;
    }
    $maxNumberOnes  = $result->{'1'};   
    print "L=".$result->{'L'}.", R=".$result->{'R'}.", binary: ".$result->{'B'}.",  ".$result->{'1'}." 1s\n";    
}


sub flipBetween {
    my $left = shift;
    my $right = shift;    
    my @aDigits  = split ( '', $binaryNumber);    
    for my $i (0..$#aDigits){
        if ( $i >= $left && $i <= $right ){
            $aDigits[$i]  = $aDigits[$i] ? 0 : 1;
        }    
    }
    return join ('', @aDigits);
}

