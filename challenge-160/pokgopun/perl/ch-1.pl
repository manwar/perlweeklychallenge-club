use strict;
use warnings;

my @m= qw/one two three four five six seven eight nine/;

my @n = @ARGV && join("",@ARGV) =~ /^\d+$/ ? @ARGV : (5,7,6);

foreach my $n (@n) {
	printf "Input: \$n = %d\n", $n;
	my $str = $m[$n-1];
	{
		my $prev = $1 if $str =~ /(\S+)$/;
		if ($prev eq "four") {
			$str .= " is magic";
			last;
		} else {
			my $next = $m[length($prev)-1];
			$str .= " is $next, $next";
		}
		redo;
	}
	$str =~ s/^(.)/\U$1/;
	printf "Output: %s.\n\n", $str;
}
