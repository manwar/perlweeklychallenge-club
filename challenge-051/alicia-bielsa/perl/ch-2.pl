use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 4;



my %hTestSet = ( '1' =>  {  given => 263, 
                            expected => 1  
                        },
                 '2' =>  {  given => 2257, 
                              expected => 0 
                        },   
                 '3' =>  {  given => 2631, 
                              expected => 0 
                        },   
                 '4' =>  {  given => 258, 
                              expected => 1  
                        }                        
               );
               
foreach my $testSet (sort keys %hTestSet){
    $hTestSet{$testSet}{result} = isColorful( $hTestSet{$testSet}{given});
}   


foreach my $testSet (sort keys %hTestSet ){ 
    my $result = 'Colorful';
    if (!$hTestSet{$testSet}{result} ){
        $result = 'Not '.$result;
    }
    is ($hTestSet{$testSet}{result} , $hTestSet{$testSet}{expected} ,"Test $testSet $hTestSet{$testSet}{given}  $result");
}

sub isColorful {
    my $number = shift;    
    my @aDigits = split ('', $number);    
    my %hProducts = ();
    my $lengthNumber = scalar(@aDigits);
    foreach my $subset  (1..$lengthNumber){        
        foreach my $i (0..$#aDigits){  
            my $setFound = 1;
            my $product  = 1;
            foreach my $s (0..$subset-1){                            
                if (defined $aDigits[$i+$s]){
                    $product *= $aDigits[$i+$s];
                } else {
                   $setFound = 0;
                }
            }
            if ($setFound){
                if (exists $hProducts{$product}){
                    return 0;
                } else {
                    $hProducts{$product} = 1;
                }
            }       
        }
    }    
    return 1;
}

