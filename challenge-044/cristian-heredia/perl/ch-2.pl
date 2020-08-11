#!/usr/bin/perl

my $total;
my $number = 200;
my @moves;

divide();

sub divide {
	while (($number %2 )==0) {
		$number = $number / 2;
		unshift @moves, 'double '; 
	}
	remove();
}

sub remove {
	$number --;
	unshift @moves, '+1$ ';
	if ($number == 1 or $number == 0) {
		print "The moves that you have to do are: \n";
		$total = @moves;
		print "$total\n";
		print 'And they are: ';
		foreach (my $i = 0; $i < @moves; $i++) {
			print "@moves[$i]";
		}
	}
	else {
		divide();
	}
}