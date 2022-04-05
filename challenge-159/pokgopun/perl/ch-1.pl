use strict;
use warnings;
#use Algorithm::Combinatorics qw/combinations/;
#use Math::Prime::Util qw/is_prime/; 

my @n = join("",@ARGV) =~ /^\d+$/ ? @ARGV : (5,7,4);

foreach my $n (@n) {
	print "Input: \$n = $n\n";

### far too complicated, comes up with this before trying to read about Farey sequence
#	my @fs;
#	if ($n > 1) {
#		@fs = sort{$a->[0]/$a->[1] <=> $b->[0]/$b->[1]} grep{ $_->[0] == 1 || ( (is_prime($_->[0]) || is_prime($_->[1]) ) && $_->[1] % $_->[0] != 0 ) } combinations([1..$n], 2);
#	}
#	@fs = ([0,1], @fs, [1,1]);
#	printf "Output: %s\n\n", join(", ", map{join "/", @$_} @fs );

### here is a simple algorithm found on https://en.wikipedia.org/wiki/Farey_sequence
	my ($a,$b,$c,$d) = (0,1,1,$n);
	printf "Output: %d/%d, %d/%d", $a, $b, $c, $d;
	if ($n > 1){
		{
			my $k = int( ($n + $b) / $d );
			($a,$b,$c,$d) = ($c,$d,$k*$c-$a,$k*$d-$b);
			printf", %d/%d", $c, $d;
			last if $c==1 && $d==1;
			redo
		}
	}
	print "\n\n";

}
