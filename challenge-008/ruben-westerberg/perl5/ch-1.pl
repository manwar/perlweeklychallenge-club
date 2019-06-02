#!/usr/bin/env perl
my $count=0;
my $number=1;
my @perlfect;
until ($count == 5) {
	my $sum=0;
	$sum += (($number % $_) == 0)?$_:0 for (1 .. $number-1);
	($count++,  print $number."\n") if ($number == $sum);
	$number++;
}
