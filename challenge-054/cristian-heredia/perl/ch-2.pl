use strict;
use warnings;
no warnings 'recursion';
use Data::Dumper;

#Collatz Conjecture
#Contributed by Ryan Thompson
#It is thought that the following sequence will always reach 1:
#
#$n = $n / 2 when $n is even
#$n = 3*$n + 1 when $n is odd
#For example, if we start at 23, we get the following sequence:
#
#23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
#Write a function that finds the Collatz sequence for any positive integer. Notice how the sequence itself may go far above the original starting number.

#Extra Credit
#Have your script calculate the sequence length for all starting numbers up to 1000000 (1e6), and output the starting number and sequence length for the longest 20 sequences.


###Variables
my $number;
my $result = '';
my $origin;
my $minimum = '2';
my $maximum = '1000000';
my $option;
my %sizes;
my @array;
my $length;
my $numberToShow = 20;

selectOption();

sub selectOption {
	
	print "Please, select the option (1 or 2) that you prefer\n 1 Introduce a number\n 2 From $minimum to $maximum, output the starting number and sequence length for the longest $numberToShow sequences\n";
	$option = <>;
	$option =~ s/^\s+|\s+$//g;
	if ($option =~ /^-?\d+$/ and $option == 1) {
		requestNumber();
	}
	elsif ($option =~ /^-?\d+$/ and $option == 2) {
		extraCredit();
	}
	else {
		selectOption();
	}
}

sub requestNumber {

	print "Please enter the number for which you want to know its Collatz sequence\n";
	$number = <>;
	$number =~ s/^\s+|\s+$//g;
	$origin = $number;
	if ($number =~ /^-?\d+$/ and $number >= 1) {
		$result = "$number";
		findCollatz();
	} 
	else {
		requestNumber();
	}
}

sub findCollatz {
	
	if ($number == 1) {
		if ($option == 1){
			print "The Collatz sequence for $origin is:\n$result\n";
		}
		else {
			countResult();
		}	
	}
	elsif ($number % 2 == 0) {
		$number = $number / 2;
		$result = $result." - $number";
		findCollatz();
	}
	else {
		$number = 3*$number + 1;
		$result = $result." - $number";
		findCollatz();
	}
}

sub extraCredit {

	$sizes{1} = 1;
	foreach (my $i = $minimum; $i <= $maximum; $i++) {
		$result = '';
		$number = $i;
		findCollatz();
		$sizes{$i} = $length;	
	}
	
	sortHash();

}

sub countResult {
	
	@array = split(' - ', $result);
	$length = @array;
}


sub sortHash {

	my $count = 0;

	foreach my $key (sort { $sizes{$b} <=> $sizes{$a} } keys %sizes) {
		print "The starting number is: $key and the length is:$sizes{$key}\n";
		$count++;
		if ($count == $numberToShow) {
			last;
		}
    }
}


