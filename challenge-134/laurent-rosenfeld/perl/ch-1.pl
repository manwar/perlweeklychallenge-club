use strict;
use warnings;
use feature "say";

my @permutations;

sub permute {
    my ($str, @vals) = @_;
    if (scalar @vals == 0) {
        push @permutations, $str;
        return;
    }
    permute("$str" . $vals[$_], @vals[0..$_-1], @vals[$_+1..$#vals]) for 0..$#vals;
}
permute "", 7, 8, 9;
say "1023456" . $_ for @permutations[0..4];
