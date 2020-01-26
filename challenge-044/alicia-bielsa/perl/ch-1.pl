#Only 100, please.
#You are given a string “123456789”.
#Write a script that would insert ”+” or ”-” in between digits so that when you evaluate, the result should be 100.

use strict;
use warnings;
use Data::Dumper;

my @aNumbers = (1..9);
my @aOperators = ('+', '-');
my $objective = 100;
my @aNumberDigits = (1,2,3);
my @aResults = ();


foreach my $i (0..$#aNumbers){
    addGroupDigits($i);
}

sub addGroupDigits {
    my $index = shift;

    my $previousNumber = $aNumbers[$index -1];
    my @aTmp = @aResults ;
    my @aAddResults = ();
    foreach my $operator (@aOperators){
        my $groupDigits = '';
        foreach my $numberDigits (@aNumberDigits){            
            if (!defined ($aNumbers[$index + $numberDigits -1  ])){
                next;
            }
            $groupDigits .= $aNumbers[$index + $numberDigits -1 ];

            if ($index != 0){                
                foreach my $resultIndex ( reverse(0..$#aTmp)  ){
                    if  ($aTmp[$resultIndex] =~ /$previousNumber$/ ) {
                        push (@aAddResults , $aTmp[$resultIndex]."$operator$groupDigits" );  
                        if (defined($aResults[$resultIndex]) && $aResults[$resultIndex] eq $aTmp[$resultIndex] ){
                            splice ( @aResults, $resultIndex, 1 );
                        }                         
                    }
                }
            } else {
                push (@aResults, "$operator$groupDigits");
            }
        }
    }    
    @aResults = (@aAddResults , @aResults);
}

foreach my $result (@aResults){
    my @aMatches = $result =~ m/([+-]{1})(\d+)/g;
    my $currentNumber = 0;
    my $previousNumber =0;
    my $currentFlagSum  = 0;
    my $previousFlagSum ;
    my $total = 0;
    foreach my $matchIndex ( 0..$#aMatches ){
        my $match = $aMatches[$matchIndex];
        if ($match eq '+'){
            $previousFlagSum = $currentFlagSum;
            $currentFlagSum = 1;
        } elsif ($match eq '-'){
           $previousFlagSum = $currentFlagSum;
            $currentFlagSum = 0;
        } else {
            $currentNumber .= $match ;
            unless ($matchIndex == $#aMatches ){
                next;
            }           
        }
        $previousNumber = $currentNumber ;
        $currentNumber = 0;
        
        next unless (defined $previousFlagSum );
        if ( $previousFlagSum  ){
            $total += $previousNumber;
        } else {
            $total -= $previousNumber;
        }               
    }
	if ($total == 100) {
	 	print "$result =  $total\n";		
	}

}


