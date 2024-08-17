use strict;
use warnings;

use v5.38;

my @test_inputs = @ARGV;
if (scalar @ARGV == 0) {
    @test_inputs = (
	"1.1.1.1",
	"255.101.1.0"
	);
}
	
for (@test_inputs) {
    printf;
    say " => " . defang($_);
}

sub defang {
    shift;
    s/\./[.]/g;
    return $_;
}
