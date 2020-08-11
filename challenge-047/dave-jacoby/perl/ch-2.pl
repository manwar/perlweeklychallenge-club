#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Write a script to print first 20 Gapful Numbers
# greater than or equal to 100.

# a Gapful Number is a number where
#   a second number is formed by the first and last digit of the number
#   which is a factor in that number.
# for example, 100 forms 10 and 100/10 = 10
# while 101 forms 11 and 101/11 = 9.181818...

# When I'm trying to be readable,
#   I declare an array to push things into
#   I use a while loop based on the size of that array
#   I iterate through numbers with ++
#   I split the number into an array with the easiest regex
#     and I join with an empty string
#   I push to the array if $n % $i == 0

my @x;
my $n = 100;
while ( scalar @x < 20 ) {
	my @n = split //, $n;
	my $i = join '', $n[0], $n[-1];
	push @x, $n if $n % $i == 0;
	$n++;
}
say join "\n", @x;

say '-' x 30;

# When I'm trying to show off a little more
#   I use a for loop ending at an abstractly large point
#   I name the for loop
#   I use state so the count variable only exists within the loop
#   I use the named last to break the loop

LOOP: for my $n ( 100 .. 1000 ) {
	state $c = 0;
	my @n = split //, $n;
	my $i = join '', $n[0], $n[-1];
	if ( 0 == $n % $i ) {
		$c++;
		say $n;
	}
	last LOOP if $c >= 20;
}

say '-' x 30;

# When I'm trying to be way-cool functional dev
#   I start with a range of 100..1000
#   I use join to stringify the output
#   I use a grep and a state variable to limit to 20
#   I use substr to pull the first and last digit from the number
#     and only create one variable in the second grep

say join "\n", grep { state $c = 0; $c++ < 20 }
	grep { my $i = join '', substr( $_, 0, 1 ), substr( $_, -1 ); $_ % $i == 0 }100 .. 1000;

say '-' x 30;

my $next = make_iterator(100);

while ( my $n = $next->() ) {
	state $c = 0;
	my $i =  my $i = join '', substr( $n, 0, 1 ), substr( $n, -1 );
	if ( 0==$n%$i){
		say $n;
		$c++;
	}
	last if $c >19;
}

sub make_iterator ( $start ) {
	return sub {
		state $i = $start;
		return $i++;
		}
}

# the right answers:
# 100, 105, 108, 110, 120,
# 121, 130, 132, 135, 140,
# 143, 150, 154, 160, 165,
# 170, 176, 180, 187, 190

