#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

# Write a script to print decimal number 0 to 50 in Octal Number System.

my $decimal_no = shift;
if ($decimal_no) {
	say convert_to_octal($decimal_no);
}
else {
	for (0 .. 50) {
		say convert_to_octal($_);
	}
}

sub convert_to_octal {
	my $n = shift;
	return 0 if ($n == 0);
	my @oct;
	while ($n > 0) {
		my $remainder = $n/8 - int($n/8);
		push @oct, $remainder * 8;
		$n = int($n/8);
	}
	return join('',reverse @oct);
}

__END__

./ch-1.pl 1023
1777

./ch-1.pl
0
1
2
3
4
5
6
7
10
11
12
13
14
15
16
17
20
21
22
23
24
25
26
27
30
31
32
33
34
35
36
37
40
41
42
43
44
45
46
47
50
51
52
53
54
55
56
57
60
61
62

