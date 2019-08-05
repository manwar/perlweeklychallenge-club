#!/usr/bin/perl
use Modern::Perl;

# Create a script to demonstrate Ackermann function. 
# The Ackermann function is defined as below, m and n are positive number:
# A(m, n) = n + 1                  if m = 0
# A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
# A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0

# Example expansions as shown in wiki page. https://en.wikipedia.org/wiki/Ackermann_function
# A(1, 2) = A(0, A(1, 1))
#         = A(0, A(0, A(1, 0)))
#         = A(0, A(0, A(0, 1)))
#         = A(0, A(0, 2))
#         = A(0, 3)
#         = 4

sub ackermann {
	my ($m, $n) = @_;
	if ($m == 0) {
		return $n+1;
	} elsif ($m > 0 and $n == 0) {
		ackermann($m-1, 1);
	} elsif ($m > 0 and $n > 0) {
		ackermann($m-1, ackermann($m, $n-1));
	} else {
		die "invalid Ackerman number pair";
	}
}	

for my $m (0..4) {
	for my $n (0..4) {
		my $a = ackermann($m,$n);
		say "ackermann($m,$n) = $a";
	}
}

__END__

time perl ch1.pl 2> /dev/null 
ackermann(0,0) = 1
ackermann(0,1) = 2
ackermann(0,2) = 3
ackermann(0,3) = 4
ackermann(0,4) = 5
ackermann(1,0) = 2
ackermann(1,1) = 3
ackermann(1,2) = 4
ackermann(1,3) = 5
ackermann(1,4) = 6
ackermann(2,0) = 3
ackermann(2,1) = 5
ackermann(2,2) = 7
ackermann(2,3) = 9
ackermann(2,4) = 11
ackermann(3,0) = 5
ackermann(3,1) = 13
ackermann(3,2) = 29
ackermann(3,3) = 61
ackermann(3,4) = 125
ackermann(4,0) = 13
ackermann(4,1) = 65533
^C

real    18m48.854s
user    18m48.360s
sys     0m0.176s

