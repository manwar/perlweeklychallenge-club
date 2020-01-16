use strict;
use warnings;

my $openingBracket = '(';
my $closingBracket = ')';
my @aBracketSymbols = ($openingBracket, $closingBracket);
my $bracketString = '';

my $lengthString = int(rand(10));
foreach my $i (0..$lengthString){
	$bracketString .= $aBracketSymbols[int(rand(2))];
}

my $balanceResult  = isStringBalanced($bracketString);
print "$bracketString - $balanceResult\n";

sub isStringBalanced {
	my $stringToCkeck = shift;
	my $balanceCount = 0;
	foreach my $bracket (split ('',$stringToCkeck)){
		if ($bracket eq $closingBracket ){
			if ( $balanceCount == 0){
				return 'KO';
			} else {
				$balanceCount --;
			}			
		} elsif ($bracket eq $openingBracket){
			$balanceCount ++;
		}
	}
	if ($balanceCount == 0 ){
		return 'OK';
	} else {
		return 'KO';
	}	
}



exit 0;