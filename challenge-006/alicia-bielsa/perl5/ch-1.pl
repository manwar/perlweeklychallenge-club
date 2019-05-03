#Challenge #1 week 6
#Create a script which takes a list of numbers from command line and 
#print the same in the compact form. For example, 
#if you pass “1,2,3,4,9,10,14,15,16” then it should print the compact form like “1-4,9,10,14-16”.


use strict;
use warnings;
use Data::Dumper;

my $askForInput = 1;
my $errorMessage = '';
my $compactedNumbers = '';
my $rangeDivider = '-';
my $numberDivider = ',';

while ($askForInput){
	
	if ($errorMessage ){
		print "ERROR: $errorMessage\n";
	}
	my $input = getInput();
	print "Input: '$input'\n";
	if ($input =~ /[\d+]/){
	  $errorMessage = '';
	  $compactedNumbers = compactNumbers($input);
	  print "Compact form: $compactedNumbers\n";
	} else {
	   $errorMessage =  "Only digits separated by commas are valid input\n";		
	}	
	if ($input =~ /^q|quit$/i){
		print "Bye bye\n";
		$askForInput = 0;
	}	
}
 
 sub getInput {   
 	print "Enter numbers separated by commas, example: 1,2,3\nEnter quit(q) to exit\n";	
	my $input = <STDIN>;
	chomp($input);	
	$input =~ s%\s+%%g;	#eliminate spaces
	$input =~ s%^,+%%g;	#eliminate commas at begining
	$input =~ s%,+$%%g;	#eliminate commas at end
	$input =~ s%,+%,%g; #eliminate duplicated commas
	return $input;
 }
 
 sub compactNumbers {
    my $numbers = shift;
	my $compactNumbers = '';
	my @aNumbers = split ( ',' , $numbers );
	
	#we eliminate duplicated numbers by passing to hash and back to array
	my %hNumbers = ();
	$hNumbers{$_}++ for (@aNumbers);
	@aNumbers = keys %hNumbers;	
	
	# we sort the numbers
	@aNumbers = sort { $a <=> $b } @aNumbers;
	
	my $rangeCount = 0;
	my $divider = '';
	
	for my $i (0 .. $#aNumbers) {
		unless  ( $i == 0 ){
		  $divider = $numberDivider;
		}
		if ( ( $i != $#aNumbers )   && ( $aNumbers[$i] +1  == $aNumbers[$i+1] ) ){
			$rangeCount++;
			if ( $rangeCount > 1 ){				
			   next;
			} 					
		} else  { 
			if ( $rangeCount > 1 ){
				$divider = $rangeDivider;
			}
			$rangeCount = 0;
		}	
		$compactNumbers .= $divider.$aNumbers[$i];
	}
	
	return $compactNumbers;
 }
 

