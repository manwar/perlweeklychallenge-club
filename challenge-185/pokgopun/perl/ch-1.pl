use strict;
use warnings;

### assign @ARGV if not present
@ARGV = ('1ac2.34f0.b1c2', 'abc1.20f1.345a') unless @ARGV;

my $regex = qr/[a-f0-9]{2}/;

foreach (@ARGV) {
	printf "Input: %s\nOutput: %s\n\n", $_, $_ =~ /^$regex{2}\.$regex{2}\.$regex{2}$/ ? join(":", $_ =~ /$regex/g) : "invalid input";
}
