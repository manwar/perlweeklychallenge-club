use strict;
use warnings;
use feature "say";

my @squares = map { $_ * $_ } 2, 3, 5, 7, 11, 13;
# say "@squares"; # 4 9 25 49 121 169 - squares of prime integers
NEXT_I: for my $i (1..500) {
    for my $j (@squares) {
        next NEXT_I if $i % $j == 0;
        last if $j > $i;
    }
    print "$i ";
}
say " ";
