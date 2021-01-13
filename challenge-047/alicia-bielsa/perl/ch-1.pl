
use strict;
use warnings;
use Data::Dumper;
use integer;

#Roman Calculator
#Write a script that accepts two roman numbers and operation. 
#It should then perform the operation on the give roman numbers and print the result.
#
#For example,
#
#perl ch-1.pl V + VI
#It should print
#
#XI
use Readonly;

Readonly::Hash my   %HASH_ROMAN_DECIMAL => ('I' => 1, 
                                            'V' => 5,
                                            'X' => 10,
                                            'L' => 50,
                                            'C' => 100, 
                                            'D' => 500, 
                                            'M' => 1000
                                          );
Readonly::Hash my   %HASH_OPERATORS => ('+' => 'addition', 
                                        '-' => 'subtration',
                                        'x' => 'multiplication',
                                        '/' => 'division',
                                        '%' => 'modulo'
                                      );                          
Readonly::Hash my   %HASH_DECIMAL_ROMAN => reverse(%HASH_ROMAN_DECIMAL);

my @aSortedDecimalValues  = sort { $b <=> $a } keys %HASH_DECIMAL_ROMAN;

unless  (scalar(@ARGV) == 3 ){
    print "ERROR: Incorrect number of arguments\n";
    usage();
	die;
}

my $firstRomanNumber    = $ARGV[0];
my $operator            = $ARGV[1];
my $secondRomanNumber   = $ARGV[2];

unless ( isRomanNumber($firstRomanNumber)  ){
    print "ERROR: Incorrect format of the first Roman number '$firstRomanNumber'\n";
    usage();
	die;
}

unless ( isRomanNumber($secondRomanNumber)){
    print "ERROR: Incorrect format of the second Roman number '$secondRomanNumber'\n";
    usage();
	die;
}

unless (isOperationAccepted($operator)){
    print "ERROR:Operator '$operator' not accepted\n";
    usage();
	die;
}

my $firstAsDecimal = romanToDecimal($firstRomanNumber);
my $secondAsDecimal = romanToDecimal($secondRomanNumber);
my $resultAsDecimal = calculateResult( $firstAsDecimal ,$operator, $secondAsDecimal);

# We leave a signed integer 
$resultAsDecimal =  sprintf("%d",$resultAsDecimal);
my $resultSign = '';
if ($resultAsDecimal < 0){
	#If a number is negative we remove the sign
	$resultAsDecimal =~ s%-%%;
	$resultSign = 'minus' ;
}
my $resultAsRoman = decimalToRoman( $resultAsDecimal );
if ($resultAsRoman){
	print "Result: $resultSign $resultAsRoman\n";
} else {
	print "Result: Zero\n";
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

sub isRomanNumber {
    my $numberToCheck = shift;
    my $isRoman = 0;
    my $romanDigits = join ( '', keys %HASH_ROMAN_DECIMAL);
	
    if ($numberToCheck =~ /^[$romanDigits]+$/ ){
        $isRoman = 1;
    }

    return $isRoman;
}

sub isOperationAccepted {
    my $operatorToCheck = shift;
    foreach my $operator ( keys %HASH_OPERATORS){
		if ($operatorToCheck eq $operator ){
			return 1;
		}
	}
    return 0;
}

sub calculateResult {
	my $number1 = shift;
	my $operator = shift;
	my $number2 = shift;
	if ($operator eq '+' ){
		return $number1 + $number2;
	} elsif($operator eq '-'){
		return $number1 - $number2;
	} elsif ($operator eq 'x'){
		return $number1 * $number2;
	} elsif ($operator eq '/'){
		return $number1 / $number2;
	} elsif ($operator eq '%'){
		return $number1 % $number2;
	}
	return 0;
}
sub usage {
    
    print  "Number of arguments 3\n";
    print  "\t1-Roman Numeral\n";
    print  "\t2-Operator\n";
    print  "\t3-Roman Numeral\n";
    print  "Example:\n\tperl ch-1.pl V + VI\n";
	print  "Accepted operators:\n";
	foreach my $operator (keys %HASH_OPERATORS){
		print "\t$operator = ".$HASH_OPERATORS{$operator}."\n";
	}
	
}