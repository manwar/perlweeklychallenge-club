use strict;
use warnings;

### Each argument being passed to script must contain 13 or 12 decimal digits (i.e. ISBN-13 with 13 digits or 12 digits for 13th to be computed
### If not, deault to the ISBN-13 given in the pwc162's task#3 example
my @sample = @ARGV && @ARGV == scalar(grep{$_ =~ /^(?:12|13)$/} map{scalar @{[$_ =~ /(\d)/g]} } @ARGV) ? @ARGV : ("978-0-306-40615-7");

### Extract only decimal digits for further processing
foreach (map{join "", $_ =~ /(\d)/g} @sample) {
	
	### From https://en.wikipedia.org/wiki/ISBN#ISBN-13_check_digit_calculation
	### r = (10 - (x1 + 3*x2 + x3 + 3*x4 + ... +x11 + 3x12) mod 10)
	my $r = 10 - eval(join(" + ", map{$_->[0]." + 3*".$_->[1]} map{[split //, $_]} $_ =~ /(\d\d)/g)) % 10; 
	
	### Convert AAABCCCDDDDDE to AAA-B-CCC-DDDDD-E
	$_ = join "-", $_ =~ /^(\d{3})(\d)(\d{3})(\d{5})(.?)/;

	### x13 = r, r < 10 or x13 = 0, r = 10
	printf "ISBN-13 check digit for '%s' is %d.\n", $_, $r < 10 ? $r : 0;
}
