use strict;
use warnings;
use feature qw /say/;

die "Two integers needed!" unless @ARGV == 2;
my ($m, $n) = @ARGV;
die "Second argument cannot be 0" if $n == 0;
my $neg = ($m <0 && $n >0 or $m > 0 && $n < 0) ? 1 : 0;
$_ = abs $_ for $m, $n;
my $quotient = 0;
while ($m > $n) {
    $m -= $n;
    $quotient++;
}
$quotient = -$quotient if $neg;
say $quotient;
