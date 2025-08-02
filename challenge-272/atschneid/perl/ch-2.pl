use strict;
use warnings;

use v5.38;

my @test_inputs = @ARGV;
if (scalar @ARGV == 0) {
    @test_inputs = (
	"hello",
	"perl",
	"raku"
	);
}

for (@test_inputs) {
    printf;
    say " : " . sum_char_abs_diff($_);
}

sub sum_char_abs_diff ($s) {
    my @slist = map { ord } split '', $s;
    my $sum = 0;
    for my $idx ( 1..scalar(@slist) - 1 ) {
	$sum += abs( $slist[$idx] - $slist[$idx-1] );
    }
    return $sum;
}
