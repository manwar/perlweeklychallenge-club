use strict;
use warnings;

my $debug = 0;

my @sample;
foreach (@ARGV) {
	die "Input must be a integer greater than 3\n" unless $_ =~ /^\d+$/ && $_ > 3;
}
push @sample, @ARGV ? @ARGV : (7,6,8);
foreach (@sample) {
	printf "Input: \$n = %d", $_;
	my $o = 0;
	for (my $b = 2; $b < $_ - 1; $b++) {
		my $n = $_;
		my %digits;
		my @digits if $debug;
		{
			my $r = $n % $b;
			$digits{$r}++;
			push @digits, $r if $debug;
			last unless $n = int($n / $b);
			redo;
		}
		if (keys %digits == 1) {
			printf(", Since %d in base %d is %s", $_, $b, join("",reverse @digits)) if $debug;
			$o = 1;
			last;
		}
	}
	printf "%sOutput: %d\n\n", $debug ? ", " : "\n", $o;
}


