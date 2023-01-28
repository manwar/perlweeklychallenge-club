use strict;
use warnings;

my $n = $ARGV[0] && $ARGV[0] =~ /^\d+$/ ? $ARGV[0] : 5; ### n default to 5 unless a number is provided as an argument
my %seen; ### hash to put "number of ways" as keys

### function that take n to generate "number of ways" and put them as keys of %seen
sub penny{
	my $p = shift @_;
	{
		last if $p;
		$seen{join(" ",sort {$b<=>$a} @_)}++; ### sort "number of ways" so they can be deduped
		return
	}
	foreach (1..$p) {
		penny($p-$_,$_,@_);
	}
}

penny($n);
my $p = keys %seen;
printf "Input: n = %d\nOutput: %d\n\nThere are %d ways of stacking %d pennies in ascending piles:\n\n", $n, $p, $p, $n;
printf("\t%s\n",$_) foreach sort keys %seen;
