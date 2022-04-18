use strict;
use warnings;
use feature "say";

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}
sub equilibrium {
    my @ary = @_;
    for my $i (1..$#ary-1) {
        return $i if sum (@ary[0..$i-1]) == sum (@ary[$i+1..$#ary]);
    }
    return -1;
}
for my $a ([1, 3, 5, 7, 9], [1, 2, 3, 4, 5], [2, 4, 2]) {
    my $formated = sprintf "%-12s", "@$a";
    say "$formated -> ", equilibrium(@$a);
}
