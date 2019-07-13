#!/usr/bin/perl
use Modern::Perl;

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-016/
# At a party a pie is to be shared by 100 guest. The first guest gets 1% of the pie, the second guest gets 2% of 
# the remaining pie, the third gets 3% of the remaining pie, the fourth gets 4% and so on.
# Write a script that figures out which guest gets the largest piece of pie.

my $verbose = shift;

my $pie = 1;
my $guest = 0;
my $slice = 0;
my $biggest_slice = 0;
for my $s (1..100) {
	my $one_percent = $pie/100;
	$slice = $s * $one_percent;
	$pie -= $slice;
	if ($slice > $biggest_slice) {
		$biggest_slice = $slice;
		$guest = $s;
	}
	say "$s $slice $pie" if ($verbose);
}

say "Guest number $guest got the largest slice of pie";

__END__

./ch1.pl 
Guest number 10 got the largest slice of pie

./ch1.pl 1
1 0.01 0.99
2 0.0198 0.9702
3 0.029106 0.941094
4 0.03764376 0.90345024
5 0.045172512 0.858277728
6 0.05149666368 0.80678106432
7 0.0564746745024 0.7503063898176
8 0.060024511185408 0.690281878632192
9 0.0621253690768973 0.628156509555295
10 0.0628156509555295 0.565340858599765
11 0.0621874944459742 0.503153364153791
12 0.0603784036984549 0.442774960455336
13 0.0575607448591937 0.385214215596143
...
96 3.73304861775776e-36 1.55543692406573e-37
97 1.50877381634376e-37 4.66631077219721e-39
98 4.57298455675327e-39 9.33262154439444e-41
99 9.23929532895049e-41 9.33262154439446e-43
100 9.33262154439446e-43 0
Guest number 10 got the largest slice of pie
