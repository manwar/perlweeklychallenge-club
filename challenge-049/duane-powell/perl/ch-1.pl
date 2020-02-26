#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/ TASK #1

my $number = shift || 55;
my ($multiple, $next, $solved) = (0,1,0);
until ($solved) {
	$multiple = $number * ++$next;

	# Test if number is comprised just 0's and 1's 
	if ($multiple =~ m/^([01]+)$/) {
		# Confirm it's not just all 1's
		$solved = ($multiple =~ m/0/);
	}
}
say "$number x $next = ".$multiple;
exit;

	
__END__

./ch-1.pl
55 x 2 = 110

./ch-1.pl 1
1 x 10 = 10

./ch-1.pl 2
2 x 5 = 10

./ch-1.pl 3
3 x 337 = 1011

./ch-1.pl 4
4 x 25 = 100

./ch-1.pl 5
5 x 2 = 10

./ch-1.pl 6
6 x 185 = 1110

./ch-1.pl 7
7 x 143 = 1001

./ch-1.pl 8
8 x 125 = 1000

./ch-1.pl 9
9 x 112345679 = 1011111111

./ch-1.pl 1031
1031 x 971 = 1001101

./ch-1.pl 2324
2324 x 434595525 = 1010000000100

