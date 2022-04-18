use strict;
use warnings;

my @m= qw/one two three four five six seven eight nine/;

my @n = @ARGV && join("",@ARGV) =~ /^\d+$/ ? @ARGV : (5,7,6);

foreach my $n (@n) {
	printf "Input: \$n = %d\n", $n;
	my $w = $m[$n-1];
	my $str = $w;
	{
		if ($w eq "four") {
			$str .= " is magic";
			last;
		} else {
			$w = $m[length($w)-1];
			$str .= " is $w, $w";
		}
		redo;
	}
	printf "Output: %s.\n\n", ucfirst($str);
}
