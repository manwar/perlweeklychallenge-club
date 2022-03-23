use strict;
use warnings;

my @sample;
if (@ARGV) {
	if (@ARGV > 1 && join("",@ARGV) =~ /^\d+$/) {
		push @sample,[@ARGV];
	} else {
		print "Input must be couple integers or more\n\n";
	}
} else {
	last if @sample;
	push @sample, [1,3,5,6,9], [2,4,6,8,10], [1,2,3,4,5];
}
foreach my $s (@sample) {
	my($n, @ans) = (scalar(@$s), 0, 1, 0);
	printf "Input: \@n = (%s)\n", join(",",@$s);
	foreach (@$s) {
		$ans[0] += $_;
		$ans[1] *= $_;
		$ans[2] += 1/$_;
	}
	@ans = ($ans[0]/$n, $ans[1]**(1/$n), $n/$ans[2]);
	printf "Output: AM = %.1f, GM = %.1f, HM = %.1f\n\n", @ans;
}

