use strict;
use warnings;
use feature "say";

my @in = ([9, 10, 7, 5, 6, 1], [3, 4, 5]);
for my $aref (@in) {
    my @result;
    my $max = @$aref[-1];
    push @result, $max;
    for my $item (reverse @$aref) {
        if ($item > $max) {
            push @result, $item;
            $max = $item;
        }
    }
    say "Input: @$aref; Output: ", join " ", reverse @result;
}
