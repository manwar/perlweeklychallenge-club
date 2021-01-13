use strict;
use warnings;

#Lucky Winner
#Suppose there are following coins arranged on a table in a line in random order.
#
#£1, 50p, 1p, 10p, 5p, 20p, £2, 2p
#
#Suppose you are playing against the computer. Player can only pick one coin at a time from either ends. Find out the lucky winner, who has the larger amounts in total?

#Variables
my @values = ('£1 ', '50p ', '1p ', '10p ', '5p ', '20p ', '£2 ', '2p ');
my @coins;
my $choise;
my $playerTotal = 0;
my $pcTotal = 0;
my $value;
my $first;
my $last;

my $length = @values;

mixArray();


sub mixArray {

	for ( 1 .. $length ) {
		push @coins, splice @values, rand @values, 1;
	}
	playerTime();
}

sub playerTime {
	
	if ($length != 0) {
		print "The coins are arranged in the following:\n@coins\n";
		print "Which end do you want to choose, left (l) or right (r)?\n";
		
		$choise = <>;
		$choise =~ s/^\s+|\s+$//g;
		
		if ($choise eq 'left' or $choise eq 'l') {
			$value = shift @coins;
			$value =~ s/^\s+|\s+$//g;
			removeLetter($value);
			$playerTotal = $playerTotal + $value;
			$length--;
			pcTime();
		}
		elsif ($choise eq 'right' or $choise eq 'r') {
			$value = pop @coins;
			$value =~ s/^\s+|\s+$//g;
			removeLetter($value);
			$playerTotal = $playerTotal + $value;
			$length--;
			pcTime();
		}
		else {
			playerTime();
		}
	}
	else {
		winner();
	}
}

sub pcTime {

	if ($length != 0) {
			
		compareResults();
		if ($choise eq 'l') {
			$value = shift @coins;
			$value =~ s/^\s+|\s+$//g;
			removeLetter($value);
			$pcTotal = $pcTotal + $value;
			$length--;
			playerTime();

		}
		elsif ($choise eq 'r') {
			$value = pop @coins;
			$value =~ s/^\s+|\s+$//g;
			removeLetter($value);
			$pcTotal = $pcTotal + $value;
			$length--;
			playerTime();
		}
		else {
			pcTime();
		}
	}
	else {
		winner();
	}
}


sub removeLetter {
	
	$value = shift();
	
	$value =~ s/£//g;
	if ($value =~ /p/) {
		$value =~ s/p//g;
		if ($value =~ /\d\d/) {
			$value = "0.".$value;
		}
		else {
			$value = "0.0".$value;
		}
	}
	return $value;
}

sub compareResults {
	
	$first = $coins[0];
	$first =~ s/^\s+|\s+$//g;
	$first = removeLetter($first);
	
	$last = $coins[$length-1];
	$last =~ s/^\s+|\s+$//g;
	$last = removeLetter($last);
	
	if ($first > $last) {
		$choise = 'l';
	}
	else {
		$choise = 'r';
	}
	return $choise;
}


sub winner {
	if ($playerTotal > $pcTotal) {
		print "The winner is the user with a total of: $playerTotal\n";
	}
	elsif ($playerTotal < $pcTotal) {
		print "The winner is the pc with a total of: $pcTotal\n";
	}
	else {
		print "There is an draw between the user and the pc, with a result of: $playerTotal\n";
	}
}

