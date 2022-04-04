use strict;
use warnings;
use Math::Factoring qw/factor/;

my @n = join("",@ARGV) =~ /^\d+$/ ? @ARGV : (5,10,20);
foreach my $n (@n) {

	print "Input: \$n = $n\n";

	my %factor;
	$factor{$_}++ foreach factor($n);
	
	my @values = values %factor;
	my $m = $n == 1 ? 1 :
		scalar(grep{$_ > 1} @values) ? 0 :
		@values % 2 ? -1 : 1;
	
	print "Output: $m\n\n";
}

