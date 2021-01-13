use strict;
use warnings;
use feature qw /say/;

my ($s, $c, $o) = @ARGV;
my $n = length $s;
die "Invalid values" if $c < 1 or $o < 1 or $c + $o > $n;
for my $i (1..$c) {
    my $tmp = substr $s, $i % $n, 1;
    substr($s, $i % $n, 1) = substr $s, ($i + $o) % $n, 1;
    substr($s, ($i + $o) % $n, 1) = $tmp;
}
say $s;
