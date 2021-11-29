use strict;
use warnings;
use feature "say";

sub mult_table {
    my ($c, $d, $k) = @{$_[0]};
    my @products;
    for my $i (1..$c) {
        for my $j (1..$d) {
            push @products, $i * $j;
        }
    }
    say +(sort {$a <=> $b} @products)[$k - 1];

}
for my $test ([2, 3, 4], [3, 3, 6]) {
    mult_table $test;
}
