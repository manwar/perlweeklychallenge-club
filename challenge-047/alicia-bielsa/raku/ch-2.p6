use v6;
sub MAIN () {

	my $totalGapfulNumbers = 20;
	my $totalGapfulNumbersFound = 0;
	my $currentNumber = 100;

	while ($totalGapfulNumbersFound < $totalGapfulNumbers ) {
		my  ( $firstDigit, $lastDigit ) = $currentNumber.comb[0,*-1];
		my $firstLastNumber = $firstDigit~$lastDigit;

		if ($currentNumber % $firstLastNumber   == 0 ) {
				say "Gapful number : $currentNumber";
				$totalGapfulNumbersFound++;        
		}
		$currentNumber++;
	}
}