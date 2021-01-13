use strict;
use warnings;
use Data::Dumper;

#Wave Array

#Any array N of non-unique, unsorted integers can be arranged into a wave-like array such that n1 ≥ n2 ≤ n3 ≥ n4 ≤ n5 and so on.

#For example, given the array [1, 2, 3, 4], possible wave arrays 
#include [2, 1, 4, 3] or [4, 1, 3, 2], since 2 ≥ 1 ≤ 4 ≥ 3 and 4 ≥ 1 ≤ 3 ≥ 2. This is not a complete list.

#Write a script to print all possible wave arrays for an integer array N of arbitrary length.
#Notes:

#When considering N of any length, note that the first element is always greater 
#than or equal to the second, and then the ≤, ≥, ≤, … sequence alternates until the end of the array.


my @aArray = (1,2,3,4,5,6);
print "Given Array: [".join( ', ', @aArray)."]\n";
my @aWaveArrays = ();
my @aTmp = ();
searchWaveArrays( \@aTmp , @aArray );


foreach my $waveArray (@aWaveArrays){
    print "\n\n[ ".join( ' ,  ', @{$waveArray})."]";
    my @aLines = ();
    my $count = 0;    
    my $waveFlag = 1;
    while  ( $waveFlag ){
        #[4, 1, 5, 2, 3]  
        my $countWaveMarkers = 0;
        foreach my $number (@{$waveArray}){
            if ($count == 0 ){
               $aLines[$count] .= "~~~~~";
            } elsif ($count == $number-1){
               $aLines[$count] .= "  ~  ";
            } elsif ($count == $number-2){
               $aLines[$count] .= " ~~~ ";
            } elsif ($count < $number){
               $aLines[$count] .= "~~~~~";                        
            } else  {
               $aLines[$count] .= "     ";   
               next;
            }
            $countWaveMarkers++;   
        }
        if ( $countWaveMarkers == 0){
            $waveFlag = 0;
        }

        $count++;         
    }
    print join("\n", reverse @aLines );
}

sub searchWaveArrays { 
    my $refWaveArray = shift;
    my @aItemsLeft = @_;    
    if (scalar( @aItemsLeft ) == 0 ){
        push (@aWaveArrays, [@{$refWaveArray}]);
        return;
    }
    my $flagUp = scalar(@{$refWaveArray}) % 2 ? 0 : 1;
    foreach my $i (0..$#aItemsLeft){
        #check the last item of the wave, if defined        
        if (defined($$refWaveArray[$#{$refWaveArray}])){
            #If the wave is going up and the current item is lower there is no wave
            if ( $flagUp  &&  $aItemsLeft[$i]  < $$refWaveArray[$#{$refWaveArray}] ){                
                next;
            }
            #if the wave is going down and the current item is higher there is no wave
            if ( !$flagUp  &&  $aItemsLeft[$i]  > $$refWaveArray[$#{$refWaveArray}] ){
                next;
            }
        }     
        my @aTmp = (@{$refWaveArray}, $aItemsLeft[$i]);       
        searchWaveArrays(  \@aTmp, @aItemsLeft[0..$i-1],  @aItemsLeft[$i+1..$#aItemsLeft]);
    }  
}

