use warnings;
use strict;

sub stepping
{
	my @n = split '', shift;
	my $m = shift @n;
	for my $n ( @n ) { return 0 unless $m + 1 == ($m = $n) }
	1;
}

my ($from, $to) = @ARGV;

print "$_\n" for grep { stepping($_) } $from .. $to;