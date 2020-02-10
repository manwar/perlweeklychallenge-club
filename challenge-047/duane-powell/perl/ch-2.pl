#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Problem:  https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/ TASK #2

my @gap;
my $n = 100;
while (scalar @gap < 20) {
	my ($a,undef,$b) = split(//,$n);
	my $x = "$a$b"; # form new number by combining first and last digit of $n
	
	push @gap, $n if ($n/$x == int($n/$x)); # $n is a gapped number if it is divisible by $x
	$n++;
}
say join(',',@gap);

__END__

./ch-2.pl
100,105,108,110,120,121,130,132,135,140,143,150,154,160,165,170,176,180,187,190

