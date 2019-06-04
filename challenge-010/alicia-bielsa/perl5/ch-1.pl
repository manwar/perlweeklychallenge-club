#Write a script to encode/decode Roman numerals. 
#For example, given Roman numeral CCXLVI, 
#it should return 246. Similarly, for decimal number 39, 
#it should return XXXIX. Checkout wikipedia page for more informaiton.
use strict;
use warnings;
use Data::Dumper;

use Readonly;

Readonly::Hash my   %HASH_ROMAN_DECIMAL => ('I' => 1, 
										    'V' => 5,
										    'X' => 10,
										    'L' => 50,
										    'C' => 100, 
										    'D' => 500, 
										    'M' => 1000
										  );
										  
Readonly::Hash my   %HASH_DECIMAL_ROMAN => reverse(%HASH_ROMAN_DECIMAL);

my @aSortedDecimalValues  = sort { $b <=> $a } keys %HASH_DECIMAL_ROMAN;

my %hTestSet  = ( 'I' => 1, 'III' => 3, 'IV' => 4,  'IX' => 9,
				 'XIV' => 14, 'XIX' => 19,  'XXXIX' => 39, 'XL' => 40,'LXXXIX' => 89,'XCIX' => 99,
				'CCXLVI' => 246,'CDXCIX' => 499,
				'CM' => 900, 'CMXCIX' => 999,
				'MMMMM' => 5000);
			 
foreach my $roman (keys %hTestSet){
	my $resultRoman= decimalToRoman( $hTestSet{$roman} );
	my $resultDecimal= romanToDecimal($roman);
	
	if ($roman eq $resultRoman){
		print "Test OK for $roman - $hTestSet{$roman}\n";
	} else {
		print "Test KO for $roman - $hTestSet{$roman} : $resultRoman\n";
	}
	
	 if ( $hTestSet{$roman}  == $resultDecimal ){
		 print "Test OK for $hTestSet{$roman} - $roman\n";
	 } else {
		 print "Test KO for $hTestSet{$roman} - $roman : $resultDecimal\n";
	 }
}


sub decimalToRoman{
	my $decimalNumber = shift;
	my $romanNumber ='';
	my @aDecimalDigits = split('', $decimalNumber);
	my $decimalBase = 1;
	while  ( defined( my $digit =  pop @aDecimalDigits)){		
		$romanNumber = getRomanFromDecimal($digit * $decimalBase,$decimalBase).$romanNumber;		
		$decimalBase *= 10;
	}	
	return $romanNumber;

}

sub getRomanFromDecimal {
	my $decimal = shift;
	my $decimalBase = shift;
	my $romanSymbol ='';
	if ($decimal >= 1000){		
		return   $HASH_DECIMAL_ROMAN{'1000'} x ( $decimal / 1000 );
	}	
	foreach my $i ( 1..$#aSortedDecimalValues){	
		while  ( ($decimal > 0 ) && ($decimal >=  $aSortedDecimalValues[$i] )) {			
			if ( $decimal ==  ($aSortedDecimalValues[$i-1] - $decimalBase)){
				$romanSymbol .= $HASH_DECIMAL_ROMAN{ $decimalBase }.$HASH_DECIMAL_ROMAN{ $aSortedDecimalValues[$i-1]};
				$decimal -=  $aSortedDecimalValues[$i-1];
				$decimal += $decimalBase;			
			} else {
				$romanSymbol .= $HASH_DECIMAL_ROMAN{ $aSortedDecimalValues[$i]};
				$decimal -= $aSortedDecimalValues[$i] ;
			}						
		}		
	}
	return $romanSymbol;
}


sub romanToDecimal {
	my $romanNumber = shift;
	my $previousValue = 0;
	my $decimalNumber = 0;
	foreach my $romanSymbol (split('',$romanNumber)) {
		if ($HASH_ROMAN_DECIMAL{$romanSymbol} > $previousValue ){
			#Previous value was substractive mode, we substract twice.
			$decimalNumber -= $previousValue * 2;
		}			
		$decimalNumber += $HASH_ROMAN_DECIMAL{$romanSymbol};
		$previousValue = $HASH_ROMAN_DECIMAL{$romanSymbol};		
	}
	return $decimalNumber;
}



