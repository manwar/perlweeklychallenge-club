use strict;
use warnings;
use feature "say";

for my $test (1..12) {
    my $bin_num = sprintf "%b", $test;
    say "$test -> ", $bin_num eq reverse ($bin_num) ? 1 : 0;
}
