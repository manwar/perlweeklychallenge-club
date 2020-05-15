use strict;
use warnings;
use feature "say";

sub compare {
    my ($m, $n) = @_;
    my @a = split //, sprintf "%08b", $m;
    my @b = split //, sprintf "%08b", $n;
    my $cnt = 0;
    for my $i (0..7) {
        $cnt++ if $a[$i] != $b[$i];
    }
    return $cnt;
}
my $diff = 0;
my @nums = @ARGV;
for my $i (0..$#nums) {
    for my $j (($i+1) .. $#nums) {
        $diff += compare $nums[$i], $nums[$j];
    }
}
say $diff;
